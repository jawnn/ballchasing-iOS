import UIKit

class HeavyTextLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        textColor = .label
        font = .systemFont(ofSize: 17, weight: .heavy)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
