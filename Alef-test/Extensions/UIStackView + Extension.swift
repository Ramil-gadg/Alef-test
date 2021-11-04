//
//  UIStackView + Extension.swift
//  Alef-test
//
//  Created by Рамил Гаджиев on 02.11.2021.
//

import UIKit

extension UIStackView {
    convenience init (firstView: UIView, secondView: UIView, verticalSpacing: CGFloat) {
        self.init(arrangedSubviews: [firstView, secondView])
        self.spacing = verticalSpacing
        distribution = .fillEqually
        axis = .vertical
    }
}
