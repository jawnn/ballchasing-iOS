import UIKit

class MatchResultRowCell: UITableViewCell {

    let backgroundCellView = FlexibleView(frame: .zero, color: .secondarySystemBackground)

    let blueTeamLabel = TitleLabel3()
    let blueScoreLabel = TitleLabel3()
    let blueTeamIcon = FlexibleView(frame: .zero, color: .systemBlue)

    let orangeTeamLabel = TitleLabel3()
    let orangeScoreLabel = TitleLabel3()
    let orangeTeamIcon = FlexibleView(frame: .zero, color: .systemOrange)

    let dateLabel = SubheadLabel()
    let finalLabel = SubheadLabel()

    let lineSeparatorView = LineSeparatorView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: String(describing: MatchResultRowCell.self))

        configureView()
        layoutViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCellData(replay: Replay) {
        let blueGoals = replay.blueTeam.goals ?? 0
        let orangeGoals = replay.orangeTeam.goals ?? 0
        blueScoreLabel.text = "\(blueGoals)"
        blueScoreLabel.textColor = blueGoals > orangeGoals ? .label : .secondaryLabel
        orangeScoreLabel.text = "\(orangeGoals)"
        orangeScoreLabel.textColor = orangeGoals > blueGoals ? .label : .secondaryLabel

        dateLabel.text = replay.date.compressDateString()
        finalLabel.text = replay.overtime ? "Final/OT" : "Final"

        let flag = replay.blueTeam.players.contains(where: { $0.name == "bojawn" }) ? true : false
        blueTeamLabel.text = flag ? "bojawn" : "blue"
        orangeTeamLabel.text = flag ? "orange" : "bojawn"
    }

    private func configureView() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(backgroundCellView)

        backgroundCellView.applyCellShadow()
        backgroundCellView.layer.cornerRadius = 4
        backgroundCellView.addSubviews(
            orangeTeamIcon, orangeTeamLabel, orangeScoreLabel,
            blueTeamIcon, blueTeamLabel, blueScoreLabel,
            lineSeparatorView, dateLabel, finalLabel
        )
    }

    private func layoutViewConstraints() {
        NSLayoutConstraint.activate([

            backgroundCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            backgroundCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            backgroundCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            blueTeamIcon.heightAnchor.constraint(equalToConstant: 16),
            blueTeamIcon.widthAnchor.constraint(equalToConstant: 16),
            blueTeamIcon.centerYAnchor.constraint(equalTo: blueTeamLabel.centerYAnchor),
            blueTeamIcon.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: 8),

            blueTeamLabel.topAnchor.constraint(equalTo: backgroundCellView.topAnchor,constant: 8),
            blueTeamLabel.leadingAnchor.constraint(equalTo: blueTeamIcon.trailingAnchor, constant: 8),
            blueTeamLabel.bottomAnchor.constraint(equalTo: orangeTeamLabel.topAnchor, constant: -8),

            blueScoreLabel.centerYAnchor.constraint(equalTo: blueTeamLabel.centerYAnchor),
            blueScoreLabel.trailingAnchor.constraint(equalTo: lineSeparatorView.leadingAnchor, constant: -12),

            orangeTeamIcon.heightAnchor.constraint(equalToConstant: 16),
            orangeTeamIcon.widthAnchor.constraint(equalToConstant: 16),
            orangeTeamIcon.centerYAnchor.constraint(equalTo: orangeTeamLabel.centerYAnchor),
            orangeTeamIcon.leadingAnchor.constraint(equalTo: backgroundCellView.leadingAnchor, constant: 8),

            orangeTeamLabel.leadingAnchor.constraint(equalTo: blueTeamIcon.trailingAnchor, constant: 8),
            orangeTeamLabel.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: -8),

            orangeScoreLabel.centerYAnchor.constraint(equalTo: orangeTeamLabel.centerYAnchor),
            orangeScoreLabel.trailingAnchor.constraint(equalTo: lineSeparatorView.leadingAnchor, constant: -12),

            lineSeparatorView.widthAnchor.constraint(equalToConstant: 1),
            lineSeparatorView.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: 4),
            lineSeparatorView.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -8),
            lineSeparatorView.bottomAnchor.constraint(equalTo: backgroundCellView.bottomAnchor, constant: -4),

            dateLabel.topAnchor.constraint(equalTo: backgroundCellView.topAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: backgroundCellView.trailingAnchor, constant: -8),

            finalLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            finalLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor)
        ])
    }

}
