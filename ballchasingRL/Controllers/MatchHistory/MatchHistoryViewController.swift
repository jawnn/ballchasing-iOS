import UIKit

protocol MatchHistoryViewType {
    var selectedPlaylist: Int { get }
    func reloadTableData()
}

class MatchHistoryViewController: UIViewController {

    private weak var tableView: UITableView!
    let playlistSegmentControl = NavigationSegmentControl(items: ["Duels", "Doubles", "Standard"])

    var presenter: MatchHistoryPresenterType!

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

        configureTableView()
        configurePlaylistSegmentControl()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = presenter
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MatchResultRowCell.self, forCellReuseIdentifier: String(describing: MatchResultRowCell.self))
        tableView.tableHeaderView = playlistSegmentControl
    }

    private func configurePlaylistSegmentControl() {
        playlistSegmentControl.addTarget(self, action: #selector(didChangePlaylistType(sender:)), for: .valueChanged)
    }

    @objc func didChangePlaylistType(sender: UISegmentedControl) {
        reloadTableData()
    }
}

extension MatchHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MatchResultRowCell else {
            print("Could return result row cell")
            return
        }
        UIView.animate(withDuration: 0.20, delay: 0, options: .autoreverse) {
            cell.backgroundCellView.alpha = 0.50
        } completion: { _ in
            cell.backgroundCellView.alpha = 1
        }

    }
}

extension MatchHistoryViewController: MatchHistoryViewType {
    var selectedPlaylist: Int {
        get {
            return playlistSegmentControl.selectedSegmentIndex
        }
    }

    func reloadTableData() {
        title = PlaylistType(rawValue: selectedPlaylist)?.title
        tableView.reloadData()
    }
}
