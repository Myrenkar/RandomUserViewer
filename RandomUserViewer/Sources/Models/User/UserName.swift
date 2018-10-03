import Foundation

struct UserName: Decodable {

    // MARK: Properties

    let first: String
    let last: String

    // MARK: Initialization

    init(firstName: String, lastName: String) {
        self.first = firstName
        self.last = lastName
    }
}
