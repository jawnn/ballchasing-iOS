import Foundation

protocol MatchDetailModelType {
    var replay: Replay { get set }
    func fetchMatchDetails(completionHandler: @escaping (Replay) -> Void)
}

class MatchDetailModel: MatchDetailModelType {
    var replay: Replay
    var matchId: String
    var interactor = ReplayInteractor()

    init(replay: Replay) {
        self.matchId = replay.id
        self.replay = replay
    }

    func fetchMatchDetails(completionHandler: @escaping (Replay) -> Void) {
        interactor.fetchMatchDetails(matchId: matchId) {
            [weak self] (replayDetails) in
            guard let replay = replayDetails else {
                return
            }
            completionHandler(replay)
        }
    }
}
