import UIKit

final class NewsViewCell: UITableViewCell {
    
    // MARK: UI

    private let newsLabel = UILabel()
    private let descripionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        embedViews()
        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Update Value
    
    func updateValue(_ news: Article?) {
        guard let news else { return }
        newsLabel.text = news.title
        descripionLabel.text = news.description
    }
}

// MARK: - EmbedViews

private extension NewsViewCell {
    func embedViews() {
        
        let subviews = [
            newsLabel,
            descripionLabel
        ]
        
        subviews.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

// MARK: - SetupAppearance

private extension NewsViewCell {
    func setupAppearance() {
        contentView.backgroundColor = .white
        
        newsLabel.font = .boldSystemFont(ofSize: 15)
        newsLabel.numberOfLines = 1
        newsLabel.minimumScaleFactor = 0.7
        newsLabel.adjustsFontSizeToFitWidth = true
        
        descripionLabel.font = .systemFont(ofSize: 10)
        descripionLabel.numberOfLines = 2
        newsLabel.minimumScaleFactor = 0.7
        newsLabel.adjustsFontSizeToFitWidth = true
    }
}

// MARK: - SetupLayout

private extension NewsViewCell {
    func setupLayout() {
        NSLayoutConstraint.activate([
            newsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newsLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -5),
            newsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descripionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descripionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descripionLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5)
        ])
    }
}
