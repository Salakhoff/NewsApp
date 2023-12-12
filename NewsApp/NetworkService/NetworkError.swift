import Foundation

enum NetworkError: Error {
    case badData
    case badResponse
    case badRequest
    case badDecode
    case badEncode
    case unknown(String)
}
