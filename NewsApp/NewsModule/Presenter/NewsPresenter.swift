import Foundation

protocol NewsViewProtocol: AnyObject {
    func updateNews(_ news: [NewsItem])
}

final class NewsPresenter {
    
    weak var view: NewsViewProtocol?
    private let networkService: NewsRepository
    
    init(view: NewsViewProtocol, newsRepository: NewsRepository) {
        self.view = view
        self.networkService = newsRepository
    }
    
    func viewDidLoad() {
        fetchNews()
    }
}

// MARK: - FetchNews
private extension NewsPresenter {
    func fetchNews() {
//        networkService.fetchNews(url: <#T##URL#>, completion: <#T##(Result<[Decodable], Error>) -> Void#>)
    }
}
