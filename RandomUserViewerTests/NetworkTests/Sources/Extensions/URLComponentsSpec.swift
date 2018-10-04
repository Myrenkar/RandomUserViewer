@testable import RandomUserViewer

import Quick
import Nimble

final class URLComponentsSpec: QuickSpec {
    override func spec() {
        describe("URLComponentsSpec") {
            var sut: URLComponents!
            var apiRequest: APIRequestStub!

            beforeEach {
                apiRequest = APIRequestStub()
                sut = URLComponents(request: apiRequest)
            }

            describe("components") {
                it("should have host created properly") {
                    expect(sut.host).to(equal(apiRequest.urlBuilder.host))
                }

                it("should have http path created properly") {
                    expect(sut.path).to(equal("/\(apiRequest.urlBuilder.root)/\(apiRequest.path)"))
                }

                it("should have scheme properly") {
                    expect(sut.scheme).to(equal(apiRequest.urlBuilder.scheme.rawValue))
                }

                it("should have query properly") {
                    expect(sut.queryItems).to(equal(apiRequest.serializeToQuery()))
                }
            }

            describe("request") {
                it("should have query item of proper type") {
                    expect(apiRequest.query.first!.value).to(equal(.int(9999)))
                }
            }
        }
    }
}
