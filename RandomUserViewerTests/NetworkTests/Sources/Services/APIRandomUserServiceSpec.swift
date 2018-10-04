import Quick
import Nimble
import RxTest

@testable import RandomUserViewer

class APIRandomUserServiceSpec: QuickSpec {
    override func spec() {
        describe("APIRandomUserService") {
            var sut: APIRandomUserService!
            var apiClientSpy: APIClientSpy!
            var scheduler: TestScheduler!
            var observer: TestableObserver<[User]>!

            beforeEach {
                apiClientSpy = APIClientSpy()
                scheduler = TestScheduler(initialClock: 0)
                observer = scheduler.createObserver([User].self)

                sut = APIRandomUserService(apiClient: apiClientSpy)
            }

            context("when getting users") {
                beforeEach {
                    _ = sut.getRandomUsers().asObservable().subscribe(observer)
                }

                it("should trigger users request") {
                    expect(apiClientSpy.performedRequest).to(beAKindOf(RandomUsersRequest.self))
                }
            }

            context("when response does not contain data") {
                beforeEach {
                    apiClientSpy.responseData = nil

                    _ = sut.getRandomUsers().asObservable().subscribe(observer)
                }

                it("should emit just completed event") {
                    expect(observer.events.count).to(equal(1))
                }
            }

            context("when response is valid and has one user") {
                beforeEach {
                    apiClientSpy.responseData = User.testUserData
                    _ = sut.getRandomUsers().asObservable().subscribe(observer)
                }

                it("should return 1 user") {
                    expect(observer.events.first!.value.element!.count).to(equal(1))
                }

                it("should robby") {
                    expect(observer.events.first!.value.element!.first!.name.first).to(equal("robby"))
                }
            }
        }
    }
}
