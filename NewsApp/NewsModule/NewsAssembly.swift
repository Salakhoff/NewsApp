import UIKit

final class NewsAssembly {
    
    static func build() -> UIViewController {
        
        let view = NewsView()
        let networkService = NetworkService()
        
        let presenter = NewsPresenter(
            view: view,
            networkService: networkService
        )
        
        view.presenter = presenter
        
        return view
    }
}
