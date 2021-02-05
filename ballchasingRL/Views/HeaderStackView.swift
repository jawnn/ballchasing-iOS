import UIKit

class HeaderStackView: UIStackView {

    init(frame: CGRect, header: String) {
        super.init(frame: frame)

        spacing = 4
        axis = .vertical
        let headerLabel = UILabel()
        headerLabel.text = header
        headerLabel.textAlignment = .center
        addArrangedSubview(headerLabel)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
