import RxSwift

@testable import RandomUserViewer

final class UserListViewModelSpy: UserListViewModelProtocol {

    // MARK: - Subjects

    private(set) var usersSubject = PublishSubject<[User]>()
    private(set) var updatedUser: User?
    private(set) var didCallFetchUsers = false

    // MARK: - UserListViewModelProtocol

    var users: Observable<[User]> {
        return usersSubject.asObservable()
    }

    let searchPhrase = PublishSubject<String?>()

    func fetchUsers() {
        didCallFetchUsers = true
    }

    func update(user: User) {
        self.updatedUser = user
    }
}
