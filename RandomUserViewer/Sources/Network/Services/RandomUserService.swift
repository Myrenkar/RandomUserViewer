import RxSwift

protocol RandomUserService {

    /// Obtains random users
    ///
    /// - Returns: Observable with array of users
    func getRandomUsers() -> Single<[User]>
}
