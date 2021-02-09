import UIKit

class RootStackView: UIStackView {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
