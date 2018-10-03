import Foundation

struct RandomUsersRequest: APIRequest {

    // MARK: - APIRequest

    var path: String { return "" }

    var query: [String : APIQueryParameter] {
        return [
            "results" : .int(100)
        ]
    }
}
