import UIKit

struct Player: Codable {
    let name: String

    let mvp: Bool?
    let stats: Stat?
    let carName: String?


    enum CodingKeys: String, CodingKey {
        case name
        case mvp
        case stats
        case carName = "car_name"
    }
}
