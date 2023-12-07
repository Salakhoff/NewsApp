import Foundation

protocol NewsPresenterProtocol {
    func fetchData()
}

final class NewsPresenter: NewsPresenterProtocol {
    
    weak var view: NewsViewProtocol?
    private let networkService: NetworkServiceProtocol?
    
    init(view: NewsViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
    }
    
    func fetchData() {
        guard let url = URL(
            string: "https://newsapi.org/v2/top-headlines/sources?apiKey=3368ec761a404c6b94722e42644d9d6d"
        ) else {
            return
        }
        
        networkService?.fetchData(url: url) { [weak self] (result: Result<NewsItem, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.view?.updateNews(data.sources)
            case .failure(let error):
                print("Ошибка. \(error.localizedDescription)")
            }
        }
    }
}
