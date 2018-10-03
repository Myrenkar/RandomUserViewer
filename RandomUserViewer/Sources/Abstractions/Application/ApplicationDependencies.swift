import RealmSwift
import Foundation

/// Describes a type that is providing application dependencies.
protocol ApplicationDependenciesProvider {
    var apiClient: APIClient { get }
    var imageProvider: ImageProviding { get }
    var randomUserService: RandomUserService { get }
    var realm: Realm { get }
}

final class DefaultApplicationDependenciesProvider: ApplicationDependenciesProvider {

    private(set) lazy var apiClient: APIClient = {
       DefaultAPIClient()
    }()

    lazy var imageProvider: ImageProviding = {
        return ImageProvider()
    }()

    lazy var randomUserService: RandomUserService = {
        APIRandomUserService(apiClient: apiClient)
    }()

    lazy var realm: Realm = {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                } else {
                    // TODO: Perform migration
                }
        })

        Realm.Configuration.defaultConfiguration = config

        return try! Realm()
    }()


}
