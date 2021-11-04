//
//  UIButton + Extension.swift
//  Alef-test
//
//  Created by Рамил Гаджиев on 03.11.2021.
//

import UIKit

extension UIButton {
    
    convenience init(text: String, color: UIColor) {
        self.init(type: .system)
        self.layer.cornerRadius = UIScreen.main.bounds.height/38
        self.layer.borderWidth = 2
        self.layer.borderColor = color.cgColor
        self.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = UIFont(name: "KohinoorBangla-Light", size: 14)
        self.setTitleColor(color, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
