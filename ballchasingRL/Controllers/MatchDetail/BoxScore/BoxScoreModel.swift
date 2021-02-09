import Foundation

protocol BoxScoreModelType {
    var replay: Replay { get set }
}

class BoxScoreModel: BoxScoreModelType {
    var replay: Replay

    init(replay: Replay) {
        self.replay = replay
    }
}
