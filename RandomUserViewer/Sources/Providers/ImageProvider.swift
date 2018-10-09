import RxSwift
import UIKit

protocol ImageProviding {
    func image(for url: URL) -> Observable<UIImage?>
}

final class ImageProvider: ImageProviding {

    // MARK: - Properties

    private let urlSession: URLSession

    // MARK: - Init

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    // MARK: - ImageProviding

    func image(for url: URL) -> Observable<UIImage?> {
         var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad

        return urlSession.rx
            .data(request: request)
            .map { UIImage(data: $0) }
    }

}
