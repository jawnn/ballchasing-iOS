import UIKit

protocol TeamComparisonPresenterType: UITableViewDataSource {
    var replay: Replay { get set }
}

class TeamComparisonPresenter: NSObject, TeamComparisonPresenterType {

    var view: TeamComparisonViewType
    var model: TeamComparisonModelType

    var replay: Replay

    init(view: TeamComparisonViewType, model: TeamComparisonModelType) {
        self.view = view
        self.model = model

        self.replay = model.replay
    }

}

enum TeamComparisonSection: Int, CaseIterable {
    case possession
    case core
    case boost

    var title: String {
        switch self {
        case .possession:
            return "Ball Possession"
        case .core:
            return "Core"
        case .boost:
            return "Boost"
        }
    }
}

// MARK: - UITableViewDatasource
extension TeamComparisonPresenter {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TeamComparisonSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TeamComparisonCell.self)) as? TeamComparisonCell,
              let blueTeamStats = model.replay.blueTeam.stats,
              let orangeTeamStats = model.replay.orangeTeam.stats else {
            return UITableViewCell()
        }

        switch indexPath.section {
        case TeamComparisonSection.possession.rawValue:
            cell.configureTitleColumns(titles: ["In Possession", "Ball Onside"], header: "")
            cell.configureTeamPossessionColumns(team: "Blue", stats: blueTeamStats)
            cell.configureTeamPossessionColumns(team: "Orange", stats: orangeTeamStats)
        case TeamComparisonSection.core.rawValue:
            cell.configureTitleColumns(titles: ["Score", "Goals", "Shots", "Shot%", "Demolitions"], header: "")
            cell.configureTeamCoreStatColumns(team: "Blue", stat: blueTeamStats)
            cell.configureTeamCoreStatColumns(team: "Orange", stat: orangeTeamStats)
        case TeamComparisonSection.boost.rawValue:
            cell.configureTitleColumns(titles: ["Collected", "Stolen", "Small Pads", "Big Pads"], header: "")
            cell.configureTeamBoostStatColumns(team: "Blue", stat: blueTeamStats)
            cell.configureTeamBoostStatColumns(team: "Orange", stat: orangeTeamStats)
        default:
            break
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case TeamComparisonSection.possession.rawValue:
            return TeamComparisonSection.possession.title
        case TeamComparisonSection.core.rawValue:
            return TeamComparisonSection.core.title
        case TeamComparisonSection.boost.rawValue:
            return TeamComparisonSection.boost.title
        default:
            return nil
        }
    }

}
