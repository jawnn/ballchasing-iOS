import UIKit

protocol MatchDetailViewType {
    func populateFinalScoreView()
    func populateMvpPlayerView()
    func configureChildrenViewControllers()
}

class MatchDetailViewController: UIViewController, MatchDetailViewType {

    var presenter: MatchDetailPresenterType!

    let finalScoreView = FinalScoreView(frame: .zero)
    let mvpPlayerView = MvpPlayerView(frame: .zero)
    let segmentControl = NavigationSegmentControl(items: ["Team Comparison", "Box Score"])

    let teamComparisonVC = TeamComparisonViewController()
    let boxScoreVC = BoxScoreViewController()
    let interactor = ReplayInteractor()

    override func loadView() {
        super.loadView()
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews(finalScoreView, mvpPlayerView, segmentControl)
        NSLayoutConstraint.activate([

            finalScoreView.heightAnchor.constraint(equalToConstant: 44),
            finalScoreView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            finalScoreView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            finalScoreView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            mvpPlayerView.topAnchor.constraint(equalTo: finalScoreView.bottomAnchor, constant: 8),
            mvpPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mvpPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mvpPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),


            segmentControl.topAnchor.constraint(equalTo: mvpPlayerView.bottomAnchor, constant: 8),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(didChangeMatchDetailView(sender:)), for: .valueChanged)
    }

    func populateMvpPlayerView() {
        mvpPlayerView.populateView(for: presenter.mvp)
    }

    func populateFinalScoreView() {
        finalScoreView.populateLabel(for: presenter.replay)
    }

    func configureChildrenViewControllers() {
        let teamComparisonModel = TeamComparisonModel(replay: self.presenter.replay)
        let teamComparisonPresenter = TeamComparisonPresenter(view: teamComparisonVC, model: teamComparisonModel)
        teamComparisonVC.presenter = teamComparisonPresenter

        let boxScoreModel = BoxScoreModel(replay: self.presenter.replay)
        let boxScorePresenter = BoxScorePresenter(view: boxScoreVC, model: boxScoreModel)
        boxScoreVC.presenter = boxScorePresenter

        setView()
    }

    func setView() {
        switch segmentControl.selectedSegmentIndex {
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

    @objc func didChangeMatchDetailView(sender: UISegmentedControl) {
        setView()
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
