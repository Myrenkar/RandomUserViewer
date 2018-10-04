import Quick
import Nimble
import RxTest
import Realm
import RealmSwift

@testable import RandomUserViewer

class UserListViewModelSpec: QuickSpec {
    override func spec() {

        beforeSuite {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        }

        beforeEach {
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        }

        describe("User list view model") {
            var randomUserServiceSpy: APIRandomUserServiceSpy!
            var sut: UserListViewModel!
            var realm: Realm!

            beforeEach {
                randomUserServiceSpy = APIRandomUserServiceSpy()
                realm = try! Realm()
                sut = UserListViewModel(userService: randomUserServiceSpy, realm: realm)
            }

            context("when fetch  users was called") {
                beforeEach {
                    _ = sut.fetchUsers()
                }

                it("should invoke get characters method") {
                    expect(randomUserServiceSpy.methodInvoked).to(beTrue())
                }
            }
        }
    }
}
