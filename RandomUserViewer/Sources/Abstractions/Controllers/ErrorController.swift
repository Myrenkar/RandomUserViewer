import UIKit

protocol ErrorControllerProtocol {
    func show(error: Error, on: UIViewController, then: @escaping ((UIAlertAction) -> Void))
}

final class ErrorController: ErrorControllerProtocol {

    func show(error: Error, on: UIViewController, then: @escaping ((UIAlertAction) -> Void)) {
        let alertController = UIAlertController(title: "Error ocuured", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: then)
        alertController.addAction(action)
        on.present(alertController, animated: true, completion: nil)
    }
}
