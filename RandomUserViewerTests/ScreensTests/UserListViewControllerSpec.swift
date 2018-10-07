import Quick
import Nimble
import RxSwift
import RxTest

@testable import RandomUserViewer

class UserListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("UserListViewController") {
            var searchControllerStub: UISearchController!
            var userListView: UsersListView!
            var userListViewModelSpy: UserListViewModelSpy!
            var sut: UserListViewController!

            beforeEach {
                searchControllerStub = UISearchController(searchResultsController: nil)
                userListViewModelSpy = UserListViewModelSpy()

                sut = UserListViewController(viewModel:
                        userListViewModelSpy,
                        imageProvider: ImageProviderSpy(),
                        searchController: searchControllerStub,
                        errorController: ErrorControllerSpy()
                    )

                UIApplication.shared.keyWindow!.rootViewController = UINavigationController(rootViewController: sut)

                userListView = (sut.view as! UsersListView)
            }

            context("when view loads") {
                describe("title view") {
                    it("should set search bar as title view") {
                        expect(sut.navigationItem.titleView).to(be(searchControllerStub.searchBar))
                    }
                }

                describe("search controller") {
                    it("shout set `obscures background during presentation` to `false`") {
                        expect(searchControllerStub.obscuresBackgroundDuringPresentation).to(beFalse())
                    }

                    it("shout set `hides navigation bar during presentation` to `false`") {
                        expect(searchControllerStub.hidesNavigationBarDuringPresentation).to(beFalse())
                    }

                    it("should have proper placeholder in search bar") {
                        expect(searchControllerStub.searchBar.placeholder).to(equal("Search for email..."))
                    }
                }
            }

            describe("user table view") {
                context("when there are 2 items") {
                    beforeEach {
                        userListViewModelSpy.usersSubject.onNext([
                            User.favorite_fixture,
                            User.non_favorite_fixture
                        ])
                    }

                    it("should display 2 items") {
                        expect(userListView.tableView.visibleCells.count).toEventually(equal(2))
                    }
                }
            }

            describe("user update") {
                context("when user was updated") {
                    beforeEach {
                        userListViewModelSpy.update(user: User.favorite_fixture)
                    }

                    it("updated user should not be nil") {
                        expect(userListViewModelSpy.updatedUser).notTo(beNil())
                    }
                }
            }
        }
    }
}
