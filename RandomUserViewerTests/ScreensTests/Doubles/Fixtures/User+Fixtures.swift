@testable import RandomUserViewer

extension User {
    static var favorite_fixture: User {
        return User(
            email: "fixed_email",
            image: UserImage.fixture,
            name: UserName.fixture,
            favourite: true
        )
    }

    static var non_favorite_fixture: User {
        return User(
            email: "fixed_email",
            image: UserImage.fixture,
            name: UserName.fixture,
            favourite: false
            )
    }
}
