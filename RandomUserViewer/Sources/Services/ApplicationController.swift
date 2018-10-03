import UIKit

final class ApplicationController {

    // MARK: Properties

    private let dependencies: ApplicationDependenciesProvider

    // MARK: Initialization

    init(dependencies: ApplicationDependenciesProvider) {
        self.dependencies = dependencies
    }

    // MARK: RootViewController

    private(set) lazy var rootViewController: UINavigationController = {
        let viewController = UserListViewController(
            viewModel: UserListViewModel(
                userService: APIRandomUserService(apiClient: dependencies.apiClient),
                realm: dependencies.realm),
            imageProvider: dependencies.imageProvider
        )
        return UINavigationController(rootViewController: viewController)
    }()

    func configureCache() {
        URLCache.shared = URLCache(memoryCapacity: 50 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: nil)
    }
    
}
