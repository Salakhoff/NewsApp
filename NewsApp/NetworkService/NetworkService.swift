import Foundation

protocol NetworkProtocol {
    func fetchData<T: Codable>(
        url: URL,
        httpMethod: HTTPMethod,
        body: Encodable?,
        headers: [String: String]?,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

final class NetworkService: NetworkProtocol {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 250
        return URLSession(configuration: configuration)
    }
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchData<T: Codable>(
        url: URL,
        httpMethod: HTTPMethod,
        body: Encodable?,
        headers: [String : String]?,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if let body = body {
            do {
                request.httpBody = try encoder.encode(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(.badEncode))
            }
        }
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        session.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.badData))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.badResponse))
            }
            
            let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedData = try self.decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(.badDecode))
                }
            case 400:
                completion(.failure(.badRequest))
            default:
                completion(.failure(.unknown("Дефолтная ошибка, что поделать...")))
            }
        }.resume()
    }
}
