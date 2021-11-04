//
//  UILabel + Extension.swift
//  Alef-test
//
//  Created by Рамил Гаджиев on 02.11.2021.
//


import UIKit

extension UILabel {
    
    convenience init (text: String, size: CGFloat = 16, color: UIColor = .black) {
        self.init()
        self.text = text
        self.textAlignment = .left
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.font = UIFont(name: "KohinoorBangla-Regular", size: size)
        self.textColor = color
        self.numberOfLines = 1
    }
}
