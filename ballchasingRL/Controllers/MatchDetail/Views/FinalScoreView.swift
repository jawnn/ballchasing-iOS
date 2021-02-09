import UIKit

class FinalScoreView: UIView {

    let blueTeamIcon = FlexibleView(frame: .zero, color: .systemBlue)
    let blueTeamLabel = MainLabel(frame: .zero)
    let blueScoreLabel = HeavyTextLabel(frame: .zero)
    let blueWinArrow: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "arrowtriangle.left.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        imageView.isHidden = true
        return imageView
    }()

    let orangeTeamIcon = FlexibleView(frame: .zero, color: .systemOrange)
    let orangeTeamLabel = MainLabel(frame: .zero)
    let orangeScoreLabel = HeavyTextLabel(frame: .zero)
    let orangeWinArrow: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "arrowtriangle.right.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        imageView.isHidden = true
        return imageView
    }()

    let finalLabel = MainLabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
        configureSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
        blueWinArrow.translatesAutoresizingMaskIntoConstraints = false
        orangeWinArrow.translatesAutoresizingMaskIntoConstraints = false
        addSubviews(
            blueTeamIcon, blueTeamLabel, blueScoreLabel, blueWinArrow,
            orangeTeamIcon, orangeTeamLabel, orangeScoreLabel, orangeWinArrow,
            finalLabel
        )
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([

            blueTeamIcon.heightAnchor.constraint(equalToConstant: 16),
            blueTeamIcon.widthAnchor.constraint(equalToConstant: 16),
            blueTeamIcon.centerYAnchor.constraint(equalTo: finalLabel.centerYAnchor),
            blueTeamIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),

            blueTeamLabel.leadingAnchor.constraint(equalTo: blueTeamIcon.trailingAnchor, constant: 8),
            blueTeamLabel.centerYAnchor.constraint(equalTo: finalLabel.centerYAnchor),

            blueScoreLabel.leadingAnchor.constraint(equalTo: blueTeamLabel.trailingAnchor, constant: 16),
            blueScoreLabel.centerYAnchor.constraint(equalTo: finalLabel.centerYAnchor),

            blueWinArrow.heightAnchor.constraint(equalToConstant: 16),
            blueWinArrow.widthAnchor.constraint(equalToConstant: 16),
            blueWinArrow.trailingAnchor.constraint(equalTo: finalLabel.leadingAnchor, constant: -6),
            blueWinArrow.centerYAnchor.constraint(equalTo: finalLabel.centerYAnchor),

            finalLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            finalLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            orangeWinArrow.heightAnchor.constraint(equalToConstant: 16),
            orangeWinArrow.widthAnchor.constraint(equalToConstant: 16),
            orangeWinArrow.leadingAnchor.constraint(equalTo: finalLabel.trailingAnchor, constant: 6),
            orangeWinArrow.centerYAnchor.constraint(equalTo: finalLabel.centerYAnchor),

            orangeScoreLabel.trailingAnchor.constraint(equalTo: orangeTeamLabel.leadingAnchor, constant: -16),
            orangeScoreLabel.centerYAnchor.constraint(equalTo: finalLabel.centerYAnchor),

            orangeTeamLabel.trailingAnchor.constraint(equalTo: orangeTeamIcon.leadingAnchor, constant: -8),
            orangeTeamLabel.centerYAnchor.constraint(equalTo: finalLabel.centerYAnchor),

            orangeTeamIcon.heightAnchor.constraint(equalToConstant: 16),
            orangeTeamIcon.widthAnchor.constraint(equalToConstant: 16),
            orangeTeamIcon.centerYAnchor.constraint(equalTo: finalLabel.centerYAnchor),
            orangeTeamIcon.leadingAnchor.constraint(equalTo: orangeTeamLabel.trailingAnchor, constant: 8),
            orangeTeamIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }

    func populateLabel(for replay: Replay) {
        let blueScore = replay.blueTeam.stats?.core.goals ?? 0
        blueScoreLabel.text = "\(blueScore)"
        blueScoreLabel.font = .systemFont(ofSize: 24, weight: .heavy)

        let orangeScore = replay.orangeTeam.stats?.core.goals ?? 0
        orangeScoreLabel.text = "\(orangeScore)"
        orangeScoreLabel.font = .systemFont(ofSize: 24, weight: .heavy)

        if blueScore > orangeScore {
            blueWinArrow.isHidden = false
        } else {
            orangeWinArrow.isHidden = false
        }

        finalLabel.text = replay.overtime ? "Final/OT" : "Final"
        let flag = replay.blueTeam.players.contains(where: { $0.name == "bojawn" }) ? true : false
        blueTeamLabel.text = flag ? "bojawn" : "Blue"
        orangeTeamLabel.text = flag ? "Orange" : "bojawn"
    }



}
