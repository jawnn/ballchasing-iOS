import UIKit

class NavigationSegmentControl: UISegmentedControl {

    override init(items: [Any]?) {
        super.init(items: items)

        self.selectedSegmentIndex = 1
        self.backgroundColor = .secondarySystemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
