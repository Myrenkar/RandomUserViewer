import Foundation

struct UserImage: Codable {

    // MARK: Properties

    let medium: URL

    // MARK: Initialization

    init(url: URL) {
        self.medium = url
    }
}
