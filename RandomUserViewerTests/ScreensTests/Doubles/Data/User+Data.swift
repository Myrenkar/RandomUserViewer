import Foundation

@testable import RandomUserViewer

extension User {
    static var testUserData: Data {
        return """
        {
        "results": [
        {
            "name":{
                "title":"mr",
                "first":"robby",
                "last":"hulsen"
            },
            "email":"robby.hulsen@example.com",
            "picture":{
                "large":"https://randomuser.me/api/portraits/men/42.jpg",
                "medium":"https://randomuser.me/api/portraits/med/men/42.jpg",
                "thumbnail":"https://randomuser.me/api/portraits/thumb/men/42.jpg"
            }
        }]

        }
        """.data(using: .utf8)!
    }
}
