import UIKit

class BodyTextLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        textColor = .label
        font = .systemFont(ofSize: 17, weight: .medium)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
