import UIKit

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

class BoxScoreViewController: UIViewController, UITableViewDataSource {

    private weak var tableView: UITableView!
    let teamSegmentControl = NavigationSegmentControl(items: ["Blue", "Orange"])

    let interactor = ReplayInteractor()

    var replay: Replay!

    override func loadView() {
        super.loadView()

        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        self.tableView = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange

        self.tableView.backgroundColor = .white
        self.tableView.dataSource = self
        self.tableView.tableHeaderView = teamSegmentControl
        self.tableView.register(BoxScoreCell.self, forCellReuseIdentifier: String(describing: BoxScoreCell.self))
        teamSegmentControl.addTarget(self, action: #selector(didChangeTeam(sender:)), for: .valueChanged)

        interactor.fetchMatchDetails { (replay) in
            guard let replay = replay else {
                print("no replay")
                return
            }
            self.replay = replay
            self.tableView.reloadData()
        }
    }

    @objc func didChangeTeam(sender: UISegmentedControl) {
        tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return BoxScoreSection.allCases.count
    }

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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BoxScoreCell.self)) as? BoxScoreCell, replay != nil else {
            return UITableViewCell()
        }
        let dataTeam = teamSegmentControl.selectedSegmentIndex % 2 == 0 ? replay.blueTeam : replay.orangeTeam
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
