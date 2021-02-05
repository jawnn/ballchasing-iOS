//
//  FlexibleView.swift
//  ballchasingRL
//
//  Created by Roberto Manese III on 2/3/21.
//

import UIKit

class FlexibleView: UIView {

    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)

        backgroundColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
