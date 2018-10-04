import Quick
import Nimble
import RealmSwift
import Realm

@testable import RandomUserViewer

final class ApplicationDependenciesProviderSpec: QuickSpec {

    override func spec() {
        describe("DefaultApplicationDependenciesProvider") {
            var sut: ApplicationDependenciesProvider!

            beforeEach {
                sut = ApplicationDependenciesProviderSpy()
            }

            context("dependency provider") {
                it("should have apiClient set") {
                    expect(sut.apiClient).to(beAKindOf(APIClientSpy.self))
                }

                it("should have user service set") {
                    expect(sut.randomUserService).to(beAKindOf(APIRandomUserServiceSpy.self))
                }

                it("should have image provider set") {
                    expect(sut.imageProvider).to(beAKindOf(ImageProviderSpy.self))
                }

                it("should have realm set") {
                    expect(sut.realm).to(beAKindOf(Realm.self))
                }
            }
        }
    }
}
