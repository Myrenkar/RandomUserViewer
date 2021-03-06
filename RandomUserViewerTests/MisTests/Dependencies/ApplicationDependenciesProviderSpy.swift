@testable import RandomUserViewer

import Realm
import RealmSwift

final class ApplicationDependenciesProviderSpy: ApplicationDependenciesProvider {
    var apiClient: APIClient { return APIClientSpy() }
    var errorController: ErrorControllerProtocol { return ErrorControllerSpy() }
    var imageProvider: ImageProviding { return ImageProviderSpy() }
    var randomUserService: RandomUserService { return APIRandomUserServiceSpy() }
    var realm: Realm { return try! Realm() }
}
