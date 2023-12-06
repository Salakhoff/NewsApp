import Foundation

final class NewsRepository {
    
    private let networkService: NetworkService?
    
    init(networkService: NetworkService?) {
        self.networkService = networkService
    }
    
    func fetchNews<T: Decodable>(
        url: URL,
        completion: @escaping (Result<[T], Error>) -> Void
    ) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            print(data)
            
        }.resume()
    }
    
}
