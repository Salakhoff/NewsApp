import Foundation

struct NewsItem: Decodable {
    let sources: [News]
}

struct News: Decodable {
    let name: String
    let description: String
    let url: String
}
