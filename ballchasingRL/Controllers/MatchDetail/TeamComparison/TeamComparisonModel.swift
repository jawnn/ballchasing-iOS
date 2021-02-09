import Foundation

protocol TeamComparisonModelType {
    var replay: Replay { get set }
}

class TeamComparisonModel: TeamComparisonModelType {
    var replay: Replay

    init(replay: Replay) {
        self.replay = replay
    }
}
