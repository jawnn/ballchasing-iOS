import UIKit

protocol BoxScoreViewType {
    var selectedSegmentIndex: Int { get }
}

class BoxScoreViewController: UIViewController, BoxScoreViewType {

    private weak var tableView: UITableView!
    let teamSegmentControl = NavigationSegmentControl(items: ["Blue", "Orange"])

    var presenter: BoxScorePresenterType!

    var selectedSegmentIndex: Int {
        get {
            return teamSegmentControl.selectedSegmentIndex
        }
    }

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
        view.backgroundColor = .systemBackground

        adjustTintColor()
        self.tableView.backgroundColor = .secondarySystemBackground
        self.tableView.dataSource = presenter
        self.tableView.tableHeaderView = teamSegmentControl
        self.tableView.register(BoxScoreCell.self, forCellReuseIdentifier: String(describing: BoxScoreCell.self))
        self.tableView.tableFooterView = UIView()
        self.tableView.tableFooterView?.backgroundColor = .systemBackground
        teamSegmentControl.addTarget(self, action: #selector(didChangeTeam(sender:)), for: .valueChanged)
    }

    @objc func didChangeTeam(sender: UISegmentedControl) {
        adjustTintColor()
        tableView.reloadData()
    }

    func adjustTintColor() {
        if selectedSegmentIndex == 0 {
            teamSegmentControl.selectedSegmentTintColor = .systemBlue
        } else {
            teamSegmentControl.selectedSegmentTintColor = .systemOrange
        }
    }

}
