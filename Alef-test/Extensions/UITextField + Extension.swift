//
//  UITextField + Extension.swift
//  Alef-test
//
//  Created by Рамил Гаджиев on 02.11.2021.
//

import UIKit


extension UITextField {
    
    convenience init (placeholder: String = "", size: CGFloat = 14, keyboardType: UIKeyboardType = .default) {
        self.init()
        self.placeholder = placeholder
        self.font = UIFont(name: "KohinoorBangla-Regular", size: size)
        self.backgroundColor = .white
        self.borderStyle = .none
        self.text = ""
        self.layer.masksToBounds = true
        self.keyboardType = keyboardType
    }
}
