import Foundation

struct NewsItem: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}
