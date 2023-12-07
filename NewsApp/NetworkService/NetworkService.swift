import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func fetchData<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}
