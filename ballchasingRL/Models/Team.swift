import Foundation

struct Team: Codable {
    let goals: Int?
    let players: [Player]
    let stats: Stat?

    enum CodingKeys: String, CodingKey {
        case goals
        case players
        case stats
    }

}
