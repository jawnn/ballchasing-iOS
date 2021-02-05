import UIKit

class MatchDetailViewController: UIViewController {

    let finalScoreView = FinalScoreView(frame: .zero)
    let segmentControl = NavigationSegmentControl(items: ["Team Comparison", "Box Score"])

    let teamComparisonVC = TeamComparisonViewController()
    let boxScoreVC = BoxScoreViewController()
    let interactor = ReplayInteractor()

    override func loadView() {
        super.loadView()
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControl)
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        segmentControl.selectedSegmentIndex = 1
        self.add(boxScoreVC)
        activateBoxScoreConstraints()
        segmentControl.addTarget(self, action: #selector(didChangeMatchDetailView(sender:)), for: .valueChanged)
    }

    @objc func didChangeMatchDetailView(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            boxScoreVC.remove()
            self.add(teamComparisonVC)
            activateTeamComparisonConstraints()
        case 1:
            teamComparisonVC.remove()
            self.add(boxScoreVC)
            activateBoxScoreConstraints()
        default:
            break
        }
    }

    func activateTeamComparisonConstraints() {
        teamComparisonVC.view.translatesAutoresizingMaskIntoConstraints = false
        teamComparisonVC.view.topAnchor.constraint(equalTo: segmentControl.bottomAnchor).isActive = true
        teamComparisonVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        teamComparisonVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        teamComparisonVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func activateBoxScoreConstraints() {
        boxScoreVC.view.translatesAutoresizingMaskIntoConstraints = false
        boxScoreVC.view.topAnchor.constraint(equalTo: segmentControl.bottomAnchor).isActive = true
        boxScoreVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        boxScoreVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        boxScoreVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}
