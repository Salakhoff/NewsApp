import Foundation

protocol NewsPresenterProtocol {
    func fetchData()
}

final class NewsPresenter: NewsPresenterProtocol {
    
    weak var view: NewsViewProtocol?
    private let networkService: NetworkProtocol?
    
    init(view: NewsViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
    }
    
    func fetchData() {
        guard let url = URL(
            string: "https://newsapi.org/v2/everything?q=apple&from=2023-12-06&to=2023-12-06&sortBy=popularity&apiKey=3368ec761a404c6b94722e42644d9d6d"
        ) else {
            return
        }
        
        networkService?.fetchData(
            url: url,
            httpMethod: .get,
            body: nil,
            headers: nil,
            completion: { [weak self] (result: Result<NewsItem, NetworkError>) in
                guard let self else { return }
                switch result {
                case .success(let success):
                    self.view?.updateNews(success.articles)
                case .failure(let failure):
                    DispatchQueue.main.async {
                        switch failure {
                        case .unknown(let description):
                            print(description)
                        case .badData:
                            print("Ваши данные - плохие...")
                        case .badResponse:
                            print("Ответ плох...")
                        case .badRequest:
                            print("С запросом точно все ок?")
                        case .badDecode:
                            print("Не удалось декодировать")
                        case .badEncode:
                            print("Не удалось отправить...")
                        }
                    }
                }
            })
    }
}
