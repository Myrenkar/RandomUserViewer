@testable import RandomUserViewer

import Quick
import Nimble

final class URLRequestSpec: QuickSpec {
    override func spec() {
        describe("URLRequestSpec") {
            var sut: URLRequest!
            var apiRequest: APIRequestStub!

            beforeEach {
                apiRequest = APIRequestStub()
                sut = try! URLRequest(request: apiRequest)
            }

            describe("request") {
                it("should have http method created properly") {
                    expect(sut.httpMethod).to(equal(apiRequest.method.rawValue))
                }

                it("should have http headers created properly") {
                    expect(sut.allHTTPHeaderFields).to(
                        equal(
                        [
                            "Accept": "application/json",
                            "Content-Type": "application/json; charset=uft-8"
                        ])
                    )
                }

                it("should have query created properly") {
                    expect(sut.url?.absoluteString).to(equal("https://fixed_host/fixed_root/fixed_path?fixed_id=9999"))
                }
            }
        }
    }
}
