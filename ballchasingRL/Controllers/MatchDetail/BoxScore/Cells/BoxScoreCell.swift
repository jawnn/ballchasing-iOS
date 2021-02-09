import UIKit

class BoxScoreCell: UITableViewCell {

    let rootStackView: RootStackView = {
        let stackView = RootStackView()
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()

    let statStackView: RootStackView = {
        let stackView = RootStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: String(describing: BoxScoreCell.self))

        selectionStyle = .none
        backgroundColor = .secondarySystemBackground
        layoutRootStackViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutRootStackViewConstraints() {
        contentView.addSubview(rootStackView)
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            rootStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            rootStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            rootStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6)
        ])
    }

    private func layoutPlayerColumn(names: [String], header: String) {
        let playerColumn = HeaderStackView(frame: .zero, header: header)
        let headerLabel = playerColumn.arrangedSubviews.first as! UILabel
        headerLabel.textAlignment = .left
        for (index, name) in names.enumerated() {
            let label = BodyTextLabel()
            label.text = name
            if index % 2 == 0 {
                label.backgroundColor = .tertiarySystemBackground
            } else {
                label.backgroundColor = .secondarySystemBackground
            }
            playerColumn.addArrangedSubview(label)
        }
        rootStackView.addArrangedSubview(playerColumn)
        playerColumn.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    func configureBoxScoreData(team: Team) {
        let playerData = team.players.compactMap({ $0.name })
        layoutPlayerColumn(names: playerData, header: "Players")

        let goalsData = team.players.compactMap({ $0.stats?.core.goals })
        layoutStatColumn(for: goalsData, header: "Goals")

        let shotsData = team.players.compactMap({ $0.stats?.core.shots })
        layoutStatColumn(for: shotsData, header: "Shots")

        let assistsData = team.players.compactMap({ $0.stats?.core.assists })
        layoutStatColumn(for: assistsData, header: "Assists")

        let savesData = team.players.compactMap({ $0.stats?.core.saves })
        layoutStatColumn(for: savesData, header: "Saves")

        rootStackView.addArrangedSubview(statStackView)
    }

    func configureBoost(team: Team) {
        let playerData = team.players.compactMap({ $0.name })
        layoutPlayerColumn(names: playerData, header: "Players")

        let bpmData = team.players.compactMap({ $0.stats?.boost.bpm })
        layoutStatColumn(for: bpmData, header: "BPM")

        let boostCollectedData = team.players.compactMap({ $0.stats?.boost.amountCollected })
        layoutStatColumn(for: boostCollectedData, header: "Collected")

        let boostStolenData = team.players.compactMap({ $0.stats?.boost.amountStolen })
        layoutStatColumn(for: boostStolenData, header: "Stolen")

        rootStackView.addArrangedSubview(statStackView)
    }

    func configureMovement(team: Team) {
        let playerData = team.players.compactMap({ $0.name })
        layoutPlayerColumn(names: playerData, header: "Players")

        let avgSpeedData = team.players.compactMap({ $0.stats?.movement.averageSpeed })
        layoutStatColumn(for: avgSpeedData, header: "Speed")

        let totalDistanceData = team.players.compactMap({ $0.stats?.movement.totalDistance })
        layoutStatColumn(for: totalDistanceData, header: "Distance")

        let powerSlideData = team.players.compactMap({ $0.stats?.movement.countPowerslide })
        layoutStatColumn(for: powerSlideData, header: "Drifts")

        rootStackView.addArrangedSubview(statStackView)
    }


    private func layoutStatColumn(for data: [Int], header: String) {
        let statColumn = HeaderStackView(frame: .zero, header: header)
        let headerLabel = statColumn.arrangedSubviews.first as! UILabel
        for (index, stat) in data.enumerated() {
            let label = MainLabel()
            if index % 2 == 0 {
                label.backgroundColor = .tertiarySystemBackground
            } else {
                label.backgroundColor = .secondarySystemBackground
            }
            label.text = "\(stat.largeNumberToCommaSeperatedString())"
            label.textAlignment = .center
            statColumn.addArrangedSubview(label)
        }
        statStackView.addArrangedSubview(statColumn)
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
