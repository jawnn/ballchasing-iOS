import UIKit

protocol MatchDetailPresenterType {
    var mvp: Player { get }
    var replay: Replay { get }
}

class MatchDetailPresenter: MatchDetailPresenterType {

    var view: MatchDetailViewType
    var model: MatchDetailModelType

    var replay: Replay {
        get {
            return model.replay
        }
    }

    var mvp: Player {
        get {
            let players = replay.blueTeam.players + replay.orangeTeam.players
            let mvp = players.filter { (player) -> Bool in
                guard let mvpResult = player.mvp else {
                    return false
                }
                return mvpResult ? true : false
            }
            return mvp.first!
        }
    }

    init(view: MatchDetailViewType, model: MatchDetailModelType) {
        self.view = view
        self.model = model

        model.fetchMatchDetails { (replay) in
            self.model.replay = replay
            self.view.populateFinalScoreView()
            self.view.populateMvpPlayerView()
            self.view.configureChildrenViewControllers()
        }
    }

}
