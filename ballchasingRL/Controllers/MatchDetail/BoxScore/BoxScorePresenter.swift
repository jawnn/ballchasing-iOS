import UIKit

protocol BoxScorePresenterType: UITableViewDataSource {
    var replay: Replay { get set }
}

class BoxScorePresenter: NSObject, BoxScorePresenterType {
    var view: BoxScoreViewType
    var model: BoxScoreModelType

    var replay: Replay

    init(view: BoxScoreViewType, model: BoxScoreModelType) {
        self.view = view
        self.model = model

        self.replay = model.replay
    }

}

enum BoxScoreSection: Int, CaseIterable {
    case core
    case boost
    case movement

    var title: String {
        switch self {
        case .core:
            return "Core Stats"
        case .boost:
            return "Boost"
        case .movement:
            return "Movement"
        }
    }
}

// MARK: -UITableViewDataSource
extension BoxScorePresenter {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case BoxScoreSection.core.rawValue:
            return BoxScoreSection.core.title
        case BoxScoreSection.boost.rawValue:
            return BoxScoreSection.boost.title
        case BoxScoreSection.movement.rawValue:
            return BoxScoreSection.movement.title
        default:
            return "Header Title"
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return BoxScoreSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BoxScoreCell.self)) as? BoxScoreCell else {
            return UITableViewCell()
        }
        let dataTeam = view.selectedSegmentIndex % 2 == 0 ? replay.blueTeam : replay.orangeTeam
        switch indexPath.section {
        case BoxScoreSection.core.rawValue:
            cell.configureBoxScoreData(team: dataTeam)
        case BoxScoreSection.boost.rawValue:
            cell.configureBoost(team: dataTeam)
        case BoxScoreSection.movement.rawValue:
            cell.configureMovement(team: dataTeam)
        default:
            break
        }
        return cell
    }
}
