import Foundation

final class NewsPresenter {
    
    weak var view: NewsViewProtocol?
    private let networkService: NetworkService
    
    init(view: NewsViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
    }
    
    func fetchData() {
        guard let url = URL(
            string: "https://newsapi.org/v2/top-headlines/sources?apiKey=3368ec761a404c6b94722e42644d9d6d"
        ) else {
            print(NetworkError.invalidURL)
            return
        }
        
        networkService.fetchData(url: url) { [weak self] (result: Result<NewsItem, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.view?.updateNews(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
