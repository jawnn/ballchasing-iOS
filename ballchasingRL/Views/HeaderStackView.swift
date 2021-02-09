import UIKit

class HeaderStackView: UIStackView {

    init(frame: CGRect = .zero, header: String, headerAlignment: NSTextAlignment = .center) {
        super.init(frame: frame)

        spacing = 4
        axis = .vertical
        distribution = .fillEqually
        let headerLabel = BodyTextLabel()
        headerLabel.text = header
        headerLabel.textColor = .label
        headerLabel.textAlignment = headerAlignment
        addArrangedSubview(headerLabel)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
