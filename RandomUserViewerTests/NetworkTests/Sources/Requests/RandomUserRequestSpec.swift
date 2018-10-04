@testable import RandomUserViewer

import Quick
import Nimble

final class RandomUserRequestSpec: QuickSpec {

    override func spec() {
        var sut: RandomUsersRequest!

        beforeEach {
            sut = RandomUsersRequest()
        }

        describe("request") {
            it("should have proper path host") {
                expect(sut.path).to(equal(""))
            }

            it("should have query item with proper name") {
                expect(sut.query.first!.key).to(equal("results"))
            }
            
            it("should have query item of proper type") {
                expect(sut.query.first!.value).to(equal(.int(100)))
            }
        }
    }
}
