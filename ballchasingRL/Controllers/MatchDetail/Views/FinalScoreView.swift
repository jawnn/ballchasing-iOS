import UIKit

class FinalScoreView: UIView {

    let blueTeamIcon = FlexibleView(frame: .zero, color: .systemBlue)
    let blueTeamLabel = TitleLabel3(frame: .zero)
    let blueScoreLabel = TitleLabel3(frame: .zero)
    let blueWinArrow = UIImageView(frame: .zero)

    let orangeTeamIcon = FlexibleView(frame: .zero, color: .systemOrange)
    let orangeTeamLabel = TitleLabel3(frame: .zero)
    let orangeScoreLabel = TitleLabel3(frame: .zero)
    let orangeWinArrow = UIImageView(frame: .zero)

    let finalLabel = TitleLabel3(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        configureSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSubviews() {
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
            blueTeamIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            blueTeamIcon.trailingAnchor.constraint(equalTo: blueTeamLabel.leadingAnchor, constant: -6),

            blueTeamLabel.trailingAnchor.constraint(equalTo: blueScoreLabel.leadingAnchor, constant: 4),

            blueScoreLabel.trailingAnchor.constraint(equalTo: blueTeamLabel.leadingAnchor, constant: 4),

            blueWinArrow.trailingAnchor.constraint(equalTo: finalLabel.leadingAnchor, constant: -6),

            finalLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            orangeWinArrow.leadingAnchor.constraint(equalTo: finalLabel.trailingAnchor, constant: 8),

            orangeScoreLabel.leadingAnchor.constraint(equalTo: orangeWinArrow.trailingAnchor, constant: 8),

            orangeTeamLabel.leadingAnchor.constraint(equalTo: orangeScoreLabel.trailingAnchor, constant: 8),

            orangeTeamIcon.heightAnchor.constraint(equalToConstant: 16),
            orangeTeamIcon.widthAnchor.constraint(equalToConstant: 16),
            orangeTeamIcon.leadingAnchor.constraint(equalTo: orangeTeamLabel.leadingAnchor, constant: 8),
            orangeTeamIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
        ])

        blueTeamLabel.text = "BLUE"
        blueScoreLabel.text = "3"

    }

}
