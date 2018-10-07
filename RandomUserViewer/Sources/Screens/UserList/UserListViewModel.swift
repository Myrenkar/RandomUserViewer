import RxSwift
import RealmSwift
import RxRealm

protocol UserListViewModelProtocol {
    var searchPhrase: PublishSubject<String?> { get }
    var users: Observable<[User]> { get }
    var error: Observable<Error?> { get }

    func fetchUsers()
    func update(user: User)
}

final class UserListViewModel: UserListViewModelProtocol {

    // MARK: Properties

    private let userService: RandomUserService
    private let realm: Realm
    private let disposeBag = DisposeBag()
    private let errorSubject = PublishSubject<Error?>()

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

    lazy var error: Observable<Error?> = {
        return errorSubject.asObservable()
    }()

    func fetchUsers() {
        userService.getRandomUsers()
            .map { $0.map{ $0.toUserEntity() } }
            .asObservable()
            .catchError({ [unowned self] error in
                self.errorSubject.onNext(error)
                return .empty()
            })
            .subscribe(Realm.rx.add(configuration: realm.configuration, update: true, onError: { [unowned self] (_, error) in
                self.errorSubject.onNext(error)
            }))
            .disposed(by: disposeBag)
    }

    func update(user: User) {
        let entity = user.toUserEntity()
        do {
            try realm.write {
                realm.add(entity, update: true)
            }
        } catch let error {
            errorSubject.onNext(error)
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
