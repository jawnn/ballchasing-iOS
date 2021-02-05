import UIKit

class BoxScoreCell: UITableViewCell {

    let rootStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let sv = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: String(describing: BoxScoreCell.self))

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

    func configureMovement(team: Team) {
        sv.axis = .horizontal
        sv.distribution = .fillProportionally

        let playerData = team.players.compactMap({ $0.name })
        layoutPlayerColumn(names: playerData, header: "Players")

        let avgSpeedData = team.players.compactMap({ $0.stats?.movement.averageSpeed })
        layoutStatColumn(for: avgSpeedData, header: "avg Speed")
        let totalDistanceData = team.players.compactMap({ $0.stats?.movement.totalDistance })
        layoutStatColumn(for: totalDistanceData, header: "tot. Distance")
        let powerSlideData = team.players.compactMap({ $0.stats?.movement.countPowerslide })
        layoutStatColumn(for: powerSlideData, header: "Powerslide")

        rootStackView.addArrangedSubview(sv)
    }

    func configureBoost(team: Team) {
        sv.axis = .horizontal
        sv.distribution = .fillProportionally

        let playerData = team.players.compactMap({ $0.name })
        layoutPlayerColumn(names: playerData, header: "Players")

        let bpmData = team.players.compactMap({ $0.stats?.boost.bpm })
        layoutStatColumn(for: bpmData, header: "BPM")
        let boostCollectedData = team.players.compactMap({ $0.stats?.boost.amountCollected })
        layoutStatColumn(for: boostCollectedData, header: "Collected")
        let boostStolenData = team.players.compactMap({ $0.stats?.boost.amountStolen })
        layoutStatColumn(for: boostStolenData, header: "Stolen")

        rootStackView.addArrangedSubview(sv)
    }

    func configureBoxScoreData(team: Team) {
        let playerData = team.players.compactMap({ $0.name })
        layoutPlayerColumn(names: playerData, header: "Players")

        sv.axis = .horizontal
        sv.distribution = .fillProportionally

        let goalsData = team.players.compactMap({ $0.stats?.core.goals })
        layoutStatColumn(for: goalsData, header: "Goals")

        let shotsData = team.players.compactMap({ $0.stats?.core.shots })
        layoutStatColumn(for: shotsData, header: "Shots")

        let assistsData = team.players.compactMap({ $0.stats?.core.assists })
        layoutStatColumn(for: assistsData, header: "Assists")

        let savesData = team.players.compactMap({ $0.stats?.core.saves })
        layoutStatColumn(for: savesData, header: "Saves")

        rootStackView.addArrangedSubview(sv)
    }

    private func layoutPlayerColumn(names: [String], header: String) {
        let playerColumn = HeaderStackView(frame: .zero, header: header)
        let headerLabel = playerColumn.arrangedSubviews.first as! UILabel
        headerLabel.textAlignment = .left
        for name in names {
            let label = UILabel()
            label.text = name
            playerColumn.addArrangedSubview(label)
        }
        rootStackView.addArrangedSubview(playerColumn)
        playerColumn.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    private func layoutStatColumn(for data: [Int], header: String) {
        let statColumn = HeaderStackView(frame: .zero, header: header)
        for stat in data {
            let label = UILabel()
            label.text = "\(stat.largeNumberToCommaSeperatedString())"
            label.textAlignment = .center
            statColumn.addArrangedSubview(label)
        }
        sv.addArrangedSubview(statColumn)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        for view in rootStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        for view in sv.arrangedSubviews {
            view.removeFromSuperview()
        }
    }

}
