import UIKit

class LineSeparatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        backgroundColor = .separator
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}
