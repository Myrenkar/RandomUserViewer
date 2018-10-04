@testable import RandomUserViewer

import Quick
import Nimble

final class APIRandomUserURLBuilder: QuickSpec {
    override func spec() {
        var sut: APIURLBuilder!

        beforeEach {
            sut = RandomUserURLBuilderStub()
        }

        describe("url builder") {
            it("should build proper host") {
                expect(sut.host).to(equal("fixed_host"))
            }

            it("should build proper host") {
                expect(sut.scheme).to(equal(.https))
            }

            it("should build proper root") {
                expect(sut.root).to(equal("fixed_root"))
            }
        }
    }
}
