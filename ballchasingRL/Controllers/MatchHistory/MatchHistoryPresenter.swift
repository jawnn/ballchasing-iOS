import UIKit

protocol MatchHistoryPresenterType: UITableViewDataSource {

}

class MatchHistoryPresenter: NSObject, MatchHistoryPresenterType {
    var view: MatchHistoryViewType
    var model: MatchHistoryModelType

    init(view: MatchHistoryViewType, model: MatchHistoryModelType) {
        self.view = view
        self.model = model

        model.loadProfileMatchHistory {
            view.reloadTableData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch view.selectedPlaylist {
        case PlaylistType.duels.rawValue:
            return model.duels.count
        case PlaylistType.doubles.rawValue:
            return model.doubles.count
        case PlaylistType.standard.rawValue:
            return model.standard.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MatchResultRowCell.self)) as? MatchResultRowCell else {
            return UITableViewCell()
        }

        switch view.selectedPlaylist {
        case PlaylistType.duels.rawValue:
            cell.configureCellData(replay: model.duels[indexPath.row])
        case PlaylistType.doubles.rawValue:
            cell.configureCellData(replay: model.doubles[indexPath.row])
        case PlaylistType.standard.rawValue:
            cell.configureCellData(replay: model.standard[indexPath.row])
        default:
            return UITableViewCell()
        }

        return cell
    }

}

// TEST
//        let orangeScore = 3
//        let blueScore = 1
//
//        cell.blueTeamLabel.text = "Blue"
//        cell.blueTeamLabel.textColor = .tertiaryLabel
//
//        cell.orangeTeamLabel.text = "Orange"
//        cell.orangeTeamLabel.textColor = .label
//
//        cell.orangeScoreLabel.text = "\(orangeScore)"
//        cell.orangeScoreLabel.textColor = .label
//        cell.blueScoreLabel.text = "\(blueScore)"
//        cell.blueScoreLabel.textColor = .tertiaryLabel
//        cell.dateLabel.text = "2021-02-03"
//        cell.finalLabel.text = indexPath.row % 2 == 0 ? "Final" : "Final/OT"
