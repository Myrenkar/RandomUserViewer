import Realm
import RealmSwift

final class UserEntity: Object {

    // MARK: Properties

    @objc dynamic var email: String = ""
    @objc dynamic var image: String?
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var favourite: Bool = false

    override static func primaryKey() -> String? {
        return "email"
    }

    convenience init(user: User) {
        self.init()
        email = user.email
        image = user.image?.medium.absoluteString
        firstName = user.name.first
        lastName = user.name.last
        favourite = user.favourite
    }

    required init() {
        super.init()
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}
