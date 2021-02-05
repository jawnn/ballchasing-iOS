import Foundation

struct ResultWrapper<T: Decodable>: Decodable {
    let count: Int
    let results: [T]
    let next: String?

    enum CodingKeys: String, CodingKey {
        case count, next
        case results = "list"
    }
}
