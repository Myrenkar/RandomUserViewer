@testable import RandomUserViewer

import Foundation

extension UserImage {

    static var fixture: UserImage {
        return UserImage(
            url: URL(string: "fixed_url")!
        )
    }
}
