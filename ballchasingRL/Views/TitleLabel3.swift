import UIKit

class TitleLabel3: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        textColor = .label
        font = .systemFont(ofSize: 17, weight: .bold)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
