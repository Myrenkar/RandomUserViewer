import Foundation

protocol UserEntityConvertible {
    init(entity: UserEntity)
    func toUserEntity() -> UserEntity
}

struct User: Decodable, UserEntityConvertible {

    // MARK: Properties

    let email: String
    let image: UserImage?
    let name: UserName

    var favourite = false

    // MARK: Initialization

    init(email: String, image: UserImage?, name: UserName, favourite: Bool) {
        self.email = email
        self.image = image
        self.name = name
        self.favourite = favourite
    }

    // MARK: Decodable

    private enum CodingKeys: String, CodingKey {
        case name
        case email
        case image = "picture"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(UserName.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        image = try container.decode(UserImage.self, forKey: .image)
    }

    // MARK: UserEntityConvertible

    init(entity: UserEntity) {
        self.email = entity.email
        self.image = UserImage(url: URL(string: entity.image ?? "")!)
        self.name = UserName(firstName: entity.firstName, lastName: entity.lastName)
        self.favourite = entity.favourite
    }

    func toUserEntity() -> UserEntity {
        return UserEntity(user: self)
    }
}
