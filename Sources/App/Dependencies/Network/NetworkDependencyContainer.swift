import Alamofire
import Foundation

final class NetworkDependencyContainer {

    lazy var session = SingleReference<Session> {
        let configuration = URLSessionConfiguration.af.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        configuration.httpAdditionalHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json; charset=utf-8"
        ]
        let cacher = ResponseCacher(behavior: .doNotCache)

        return Session(
            configuration: configuration,
            cachedResponseHandler: cacher
        )
    }
}
