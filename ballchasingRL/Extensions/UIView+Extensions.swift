import UIKit

extension UIView {
    func applyCellShadow() {
        layer.shadowColor = UIColor.systemFill.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 0.5
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
