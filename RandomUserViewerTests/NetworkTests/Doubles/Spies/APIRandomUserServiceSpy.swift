@testable import RandomUserViewer

import RxSwift

final class APIRandomUserServiceSpy: RandomUserService {
    var methodInvoked = false

    func getRandomUsers() -> Single<[User]> {
        methodInvoked = true

        return Single.just([])
    }
}
