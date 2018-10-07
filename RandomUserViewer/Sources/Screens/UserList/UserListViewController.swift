import UIKit
import RxSwift
import RxCocoa
import RxRealm

final class UserListViewController: ViewController {

    // MARK: - Properties

    private let viewModel: UserListViewModelProtocol
    private let imageProvider: ImageProviding
    private let searchController: UISearchController
    private let errorController: ErrorControllerProtocol

    private let userListView = UsersListView()
    private let disposeBag = DisposeBag()

    // MARK: - Initialization

    init(viewModel: UserListViewModelProtocol,
         imageProvider: ImageProviding,
         searchController: UISearchController = UISearchController(searchResultsController: nil),
         errorController: ErrorControllerProtocol
        ) {
        self.searchController = searchController
        self.viewModel = viewModel
        self.imageProvider = imageProvider
        self.errorController = errorController
        super.init()
    }

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchUsers()
    }

    override func loadView() {
        view = userListView
    }

    override func setupProperties() {
        super.setupProperties()

        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for email..."

        userListView.tableView.registerClass(UserCell.self)
    }

    override func setupNavigationItem() {
        super.setupNavigationItem()

        title = "Random users"
        navigationItem.titleView = searchController.searchBar
    }

    override func setupBindings() {
        super.setupBindings()

        searchController.searchBar.rx.text
            .debounce(0.5, scheduler: MainScheduler.instance)
            .bind(to: viewModel.searchPhrase)
            .disposed(by: disposeBag)

        viewModel.users
            .bind(to: userListView.tableView.rx.items(cellIdentifier: UserCell.reuseIdentifier, cellType: UserCell.self)) { [unowned self] _ , element, cell in
                cell.nameLabel.text = element.name.first.capitalized
                cell.emailLabel.text = element.email
                cell.favouriteImageView.isHidden = !element.favourite

                if let url = element.image?.medium {
                    self.imageProvider.image(for: url)
                        .bind(to: cell.userImageView.rx.image)
                        .disposed(by: cell.disposeBag)
                }
            }
            .disposed(by: disposeBag)

        userListView.tableView.rx.modelSelected(User.self)
            .subscribe(onNext: { [unowned self] user in
                var newUser = user
                newUser.favourite = !user.favourite
                self.viewModel.update(user: newUser)
            })
            .disposed(by: disposeBag)

        viewModel.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] error in
                guard let error = error else { return }
                self.errorController.show(error: error, on: self, then: { _ in })
            })
            .disposed(by: disposeBag)

    }
}

