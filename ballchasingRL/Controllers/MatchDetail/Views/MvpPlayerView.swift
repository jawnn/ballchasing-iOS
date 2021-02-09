import UIKit

class MvpPlayerView: UIView {

    var rootStackView = HeaderStackView(frame: .zero, header: "")
    let statRow: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .secondarySystemBackground
        layoutRootStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutRootStackView() {
        rootStackView.spacing = 8
        rootStackView.alignment = .center
        rootStackView.distribution = .fillProportionally
        addSubview(rootStackView)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -4),
        ])
    }

    func populateView(for mvp: Player) {
        configureStatsRow(for: mvp)
    }

    func configureStatsRow(for mvp: Player) {
        guard let mvpStats = mvp.stats else {
            print("cannot get mvp stats to configure rows")
            return
        }

        let headerLabel = rootStackView.arrangedSubviews.first as! UILabel
        headerLabel.text = "MVP"
        headerLabel.font = .systemFont(ofSize: 20, weight: .heavy)

        let nameLabel = MainLabel()
        nameLabel.text = mvp.name
        rootStackView.addArrangedSubview(nameLabel)

        layoutStatColumn(stat: mvpStats.core.score, header: "Score")
        layoutStatColumn(stat: mvpStats.core.goals, header: "Goals")
        layoutStatColumn(stat: mvpStats.core.assists, header: "Assists")
        layoutStatColumn(stat: mvpStats.core.saves, header: "Saves")
        layoutStatColumn(stat: mvpStats.core.shots, header: "Shots")
        rootStackView.addArrangedSubview(statRow)
        statRow.leadingAnchor.constraint(equalTo: rootStackView.leadingAnchor).isActive = true
        statRow.trailingAnchor.constraint(equalTo: rootStackView.trailingAnchor).isActive = true
    }

    func layoutStatColumn(stat: Int, header: String) {
        let statColumn = HeaderStackView(frame: .zero, header: header)
        let statLabel = MainLabel()
        statLabel.textColor = .label
        statLabel.text = "\(stat)"
        statLabel.textAlignment = .center
        statColumn.addArrangedSubview(statLabel)
        statRow.addArrangedSubview(statColumn)
    }

}
