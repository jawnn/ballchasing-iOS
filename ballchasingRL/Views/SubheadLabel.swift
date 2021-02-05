import UIKit

class SubheadLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        textColor = .label
        font = .systemFont(ofSize: 15, weight: .regular)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
