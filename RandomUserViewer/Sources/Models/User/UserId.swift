import Foundation

struct UserId: Decodable {

    // MARK: Properties

    let value: String?

    // MARK: Initialization

    init(value: String?) {
        self.value = value
    }
}
