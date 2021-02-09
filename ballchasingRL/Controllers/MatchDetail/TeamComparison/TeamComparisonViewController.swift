import UIKit

protocol TeamComparisonViewType {
    
}

class TeamComparisonViewController: UIViewController, TeamComparisonViewType {

    var presenter: TeamComparisonPresenter!
    private weak var tableView: UITableView!

    override func loadView() {
        super.loadView()

        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        self.tableView = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.backgroundColor = .secondarySystemBackground
        tableView.dataSource = presenter
        tableView.register(TeamComparisonCell.self, forCellReuseIdentifier: String(describing: TeamComparisonCell.self))
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.backgroundColor = .secondarySystemBackground
    }

}
