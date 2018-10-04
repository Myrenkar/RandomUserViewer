@testable import RandomUserViewer

struct APIRequestStub: APIRequest {
    var method: Method { return .get }
    var path: String { return "fixed_path" }
    var urlBuilder: APIURLBuilder { return RandomUserURLBuilderStub() }
    var query: [String : APIQueryParameter] {
        return ["fixed_id" : .int(9999)]
    }
}
