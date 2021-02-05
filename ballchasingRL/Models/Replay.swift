import Foundation

enum PlaylistType: Int {
    case duels, doubles, standard

    var title: String {
        switch self {
        case .duels:
            return "Ranked Duels"
        case .doubles:
            return "Ranked Doubles"
        case .standard:
            return "Ranked Standard"
        }
    }
}

struct Replay: Decodable {
    let id: String
    let replayDetailsRequestURL: String
    let playlistName: String
    let overtime: Bool
    let date: String

    let blueTeam: Team
    let orangeTeam: Team

    enum CodingKeys: String, CodingKey {
        case id, overtime, date
        case playlistName = "playlist_name"
        case replayDetailsRequestURL = "link"
        case blueTeam = "blue"
        case orangeTeam = "orange"
    }

}
