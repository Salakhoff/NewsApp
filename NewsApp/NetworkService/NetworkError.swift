import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case networkError(Error)

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Error decoding data"
        case .networkError(let underlyingError):
            return "Network error: \(underlyingError.localizedDescription)"
        }
    }
}
