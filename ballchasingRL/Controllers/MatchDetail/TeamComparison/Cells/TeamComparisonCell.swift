import UIKit

class TeamComparisonCell: UITableViewCell {

    let rootStackView: RootStackView = {
        let stackView = RootStackView(frame: .zero)
        stackView.axis = .horizontal
        return stackView
    }()

    let statStackView: RootStackView = {
        let stackView = RootStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: String(describing: TeamComparisonCell.self))

        selectionStyle = .none
        backgroundColor = .secondarySystemBackground
        layoutRootStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutRootStackView() {
        contentView.addSubview(rootStackView)
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configureTitleColumns(titles: [String], header: String) {
        let titleStackView = HeaderStackView(header: header)
        for (index, title) in titles.enumerated() {
            let label = BodyTextLabel()
            label.text = title
            label.backgroundColor = index % 2 == 0 ? .tertiarySystemBackground : .secondarySystemBackground
            titleStackView.addArrangedSubview(label)
        }
        rootStackView.addArrangedSubview(titleStackView)
    }

    func configureTeamBoostStatColumns(team: String, stat: Stat) {
        let statColumn = HeaderStackView(header: team)
        let data: [String] = [
            stat.boost.amountCollected.largeNumberToCommaSeperatedString(),
            stat.boost.amountStolen.largeNumberToCommaSeperatedString(),
            String(stat.boost.countCollectedSmall),
            String(stat.boost.countCollectedBig)
        ]
        for (index, item) in data.enumerated() {
            let label = MainLabel()
            label.text = item
            label.textAlignment = .center
            label.backgroundColor = index % 2 == 0 ? .tertiarySystemBackground : .secondarySystemBackground
            statColumn.addArrangedSubview(label)
        }
        rootStackView.addArrangedSubview(statColumn)
        statColumn.widthAnchor.constraint(equalToConstant: 75).isActive = true
    }

    func configureTeamCoreStatColumns(team: String, stat: Stat) {
        let statColumn = HeaderStackView(header: team)
        let data: [String] = [
            stat.core.score.largeNumberToCommaSeperatedString(), "\(stat.core.goals)", "\(stat.core.shots)",
            String(format: "%.0f", stat.core.shootingPercentage) + "%", "\(stat.demo.inflicted)"
        ]
        for (index, item) in data.enumerated() {
            let label = MainLabel()
            label.text = item
            label.textAlignment = .center
            label.backgroundColor = index % 2 == 0 ? .tertiarySystemBackground : .secondarySystemBackground
            statColumn.addArrangedSubview(label)
        }
        rootStackView.addArrangedSubview(statColumn)
        statColumn.widthAnchor.constraint(equalToConstant: 75).isActive = true
    }

    func configureTeamPossessionColumns(team: String, stats: Stat) {
        let statColumn = HeaderStackView(header: team)
        let inPossession = Int(stats.ball!.possessionTime!).numberToDigitalTime()
        let ballOnside = Int(stats.ball!.timeInSide!).numberToDigitalTime()
        for (index, stat) in [inPossession, ballOnside].enumerated() {
            let label = MainLabel()
            label.backgroundColor = index % 2 == 0 ? .tertiarySystemBackground : .secondarySystemBackground
            label.textAlignment = .center
            label.text = "\(stat)"
            statColumn.addArrangedSubview(label)
        }
        rootStackView.addArrangedSubview(statColumn)
        statColumn.widthAnchor.constraint(equalToConstant: 75).isActive = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        for view in rootStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        for view in statStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
    }

}
