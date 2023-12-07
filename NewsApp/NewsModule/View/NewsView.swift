import UIKit

protocol NewsViewProtocol: AnyObject {
    func updateNews(_ news: [Article])
    func showError(message: String)
    
    func updateView()
}

final class NewsView: UIViewController {
    
    // MARK: Properties
    
    var presenter: NewsPresenterProtocol?
    private var newsData: [Article]?
    
    // MARK: UI
    
    private let newsTableView = UITableView()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedViews()
        setupAppearance()
        setupLayout()
        setupBehaviour()
        registerCell()
        
        presenter?.fetchData()
    }
}

// MARK: - UITableViewDelegate

extension NewsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

// MARK: - UITableViewDataSource

extension NewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsData?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellIdentifiers.cellIdentifier,
            for: indexPath
        ) as? NewsViewCell else {
            return UITableViewCell()
        }
        
        cell.updateValue(newsData?[indexPath.row])
        
        return cell
    }
}

// MARK: - SetupBehaviour

private extension NewsView {
    func setupBehaviour() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
}

// MARK: - EmbedViews

private extension NewsView {
    func embedViews() {
        view.addSubview(newsTableView)
        
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - SetupLayout

private extension NewsView {
    func setupLayout() {
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - RegisterCell

private extension NewsView {
    func registerCell() {
        newsTableView.register(
            NewsViewCell.self,
            forCellReuseIdentifier: CellIdentifiers.cellIdentifier
        )
    }
}

// MARK: - SetupAppearance

private extension NewsView {
    func setupAppearance() {
        title = "News"
        view.backgroundColor = .white
        
        newsTableView.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - NewsViewProtocol

extension NewsView: NewsViewProtocol {
    func updateNews(_ news: [Article]) {
        newsData = news
        updateView()
    }
    
    func showError(message: String) {
        print("Ошибка")
    }
    
    func updateView() {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
}
