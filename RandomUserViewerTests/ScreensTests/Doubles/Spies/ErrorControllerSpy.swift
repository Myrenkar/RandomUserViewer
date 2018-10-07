import UIKit

@testable import RandomUserViewer

final class ErrorControllerSpy: ErrorControllerProtocol {

    // MARK: - Spying

    private(set) var capturedError: Error?
    private(set) var capturedAction: ((UIAlertAction) -> Void)?
    private(set) var capturedViewController: UIViewController?


    // MARK: - ErrorControllerProtocol

    func show(error: Error, on: UIViewController, then: @escaping ((UIAlertAction) -> Void)) {
        capturedError = error
        capturedViewController = on
        capturedAction = then
    }

}
