import RxSwift
import UIKit

@testable import RandomUserViewer

class ImageProviderSpy: ImageProviding {

    // MARK: - Spying

    private(set) var capturedUrl: URL?

    // MARK: - Properties

    var resultImage = PublishSubject<UIImage?>()

    // MARK: - ImageProviding

    func image(for url: URL) -> Observable<UIImage?> {
        capturedUrl = url

        return resultImage.asObservable()
    }
}
