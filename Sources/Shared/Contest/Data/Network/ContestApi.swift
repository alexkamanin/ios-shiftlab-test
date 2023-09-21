import Alamofire
import Foundation

final class ContestApi {

    private let session: Session

    init(session: Session) {
        self.session = session
    }

    func getAll() async throws -> [ContestModel] {
        return try await withCheckedThrowingContinuation { continuation in
            session.request(
                "https://kontests.net/api/v1/all",
                method: .get
            )
            .responseDecodable { (response: DataResponse<[ContestModel], AFError>) in
                switch response.result {
                    case let .success(data):
                        continuation.resume(returning: data)
                    case let .failure(error):
                        let statusCode = response.response?.statusCode
                        var jsonErrorBody: String? {
                            if let data = response.data {
                                return String(data: data, encoding: .utf8)
                            } else {
                                return nil
                            }
                        }
                        continuation.resume(throwing: self.handleError(statusCode: statusCode, jsonBody: jsonErrorBody, error: error))
                }
            }
        }
    }

    private func handleError(statusCode: Int?, jsonBody: String?, error: AFError) -> Error {
        let underlyingError = error.underlyingError as? NSError

        let connectionErrorCodes = [
            NSURLErrorNotConnectedToInternet,
            NSURLErrorTimedOut,
            NSURLErrorInternationalRoamingOff,
            NSURLErrorDataNotAllowed,
            NSURLErrorCannotFindHost,
            NSURLErrorCannotConnectToHost,
            NSURLErrorNetworkConnectionLost,
        ]

        if underlyingError != nil && connectionErrorCodes.contains(underlyingError!.code) {
            return underlyingError!
        }

        return error
    }
}
