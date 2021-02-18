import Foundation

class Profile {
    static let currentUser = Profile()

    let uploaderId: String = UserDefaults.standard.string(forKey: "steamId") ?? "noId"
    var duels: [Replay] = []
    var doubles: [Replay] = []
    var standard: [Replay] = []
}
