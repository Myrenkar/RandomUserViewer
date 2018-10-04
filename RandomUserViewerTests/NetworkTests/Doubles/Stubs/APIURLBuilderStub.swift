@testable import RandomUserViewer

struct RandomUserURLBuilderStub: APIURLBuilder {
    var root: String { return "fixed_root" }
    var host: String { return "fixed_host" }
    var scheme: Scheme { return .https }
}
