import RxSwift
import RealmSwift
import RxRealm

protocol UserListViewModelProtocol {
    var searchPhrase: PublishSubject<String?> { get }
    var users: Observable<[User]> { get }

    func fetchUsers()
    func update(user: User)
}

final class UserListViewModel: UserListViewModelProtocol {

    // MARK: Properties

    private let userService: RandomUserService
    private let realm: Realm
    private let disposeBag = DisposeBag()

    // MARK: Initialization

    init(userService: RandomUserService, realm: Realm) {
        self.userService = userService
        self.realm = realm
    }

    // MARK: UserListViewModelProtocol

    let searchPhrase = PublishSubject<String?>()

    lazy var users: Observable<[User]> = {
        return Observable
            .combineLatest(storedUsers, searchPhrase.startWith(""))
            .map { users, searchPhrase in
                guard let searchPhrase = searchPhrase, !searchPhrase.isEmpty else { return users }
                return users.filter { user in user.email.lowercased().contains(searchPhrase.lowercased()) }
            }
    }()

    func fetchUsers() {
        userService.getRandomUsers()
            .map { $0.map{ $0.toUserEntity() } }
            .asObservable()
            .subscribe(Realm.rx.add(configuration: realm.configuration, update: true, onError: nil))
            .disposed(by: disposeBag)
    }

    func update(user: User) {
        let entity = user.toUserEntity()
        try! realm.write {
            realm.add(entity, update: true)
        }
    }

    // MARK: - Private

    private lazy var storedUsers: Observable<[User]> = {
        return Observable
            .collection(from: realm.objects(UserEntity.self), synchronousStart: true)
            .map { $0.toArray() }
            .map { $0.map { User(entity: $0) } }
            .map { $0.sorted(by: { $0.name.first < $1.name.first }) }
    }()
}
