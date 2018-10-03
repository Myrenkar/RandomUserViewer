import Foundation
import RxSwift

final class APIRandomUserService: RandomUserService {

    // MARK: - Properties

    private let apiClient: APIClient

    // MARK: - Init

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    // MARK: - RandomUserService

    func getRandomUsers() -> Single<[User]> {
        return apiClient.perform(request: RandomUsersRequest())
            .filter { $0.data != nil }
            .map { try JSONDecoder().decode(RandomUserResponse.self, from: $0.data!) }
            .map { $0.results }
            .asObservable()
            .asSingle()
    }

    // MARK: - Private

    private struct RandomUserResponse: Decodable {
        let results: [User]
    }
}
