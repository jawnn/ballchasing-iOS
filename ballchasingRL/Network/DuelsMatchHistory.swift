import Foundation

struct DuelsMatchHistory: APIResource {
    typealias ModelType = Replay
    var scheme: String = "https"
    var host: String = "ballchasing.com"
    var methodPath: String = "/api/replays"
    var queryItems: [URLQueryItem] = [
        URLQueryItem(name: "uploader", value: "76561198025496206"),
        URLQueryItem(name: "playlist", value: "ranked-duels"),
        URLQueryItem(name: "replay-date-after", value: "2021-01-01T01:30:13Z")
    ]
}

struct DoublesMatchHistory: APIResource {
    typealias ModelType = Replay
    var scheme: String = "https"
    var host: String = "ballchasing.com"
    var methodPath: String = "/api/replays"
    var queryItems: [URLQueryItem] = [
        URLQueryItem(name: "uploader", value: "76561198025496206"),
        URLQueryItem(name: "playlist", value: "ranked-doubles"),
        URLQueryItem(name: "replay-date-after", value: "2021-01-01T01:30:13Z")
    ]
}

struct StandardMatchHistory: APIResource {
    typealias ModelType = Replay
    var scheme: String = "https"
    var host: String = "ballchasing.com"
    var methodPath: String = "/api/replays"
    var queryItems: [URLQueryItem] = [
        URLQueryItem(name: "uploader", value: "76561198025496206"),
        URLQueryItem(name: "playlist", value: "ranked-standard"),
        URLQueryItem(name: "replay-date-after", value: "2021-01-01T01:30:13Z")
    ]
}

struct MatchDetailsResource: APIResource {
    typealias ModelType = Replay
    var scheme: String = "https"
    var host: String = "ballchasing.com"
    var methodPath: String = "/api/replays/c89c4888-4e28-4f36-b6da-03f007f49e86"
    var queryItems: [URLQueryItem] = []
}
