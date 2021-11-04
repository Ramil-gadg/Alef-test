//
//  CustomView.swift
//  Alef-test
//
//  Created by Рамил Гаджиев on 02.11.2021.
//

import UIKit

class CustomView: UIView {
    
    
    private var label = UILabel(text: "", size: 14, color: .gray)
    var textField = UITextField(placeholder: "", size: 14)
    
    
    init(frame: CGRect, labelText: String, keyboardType: UIKeyboardType = .default) {
        self.label.text = labelText
        self.textField.keyboardType = keyboardType
        super.init(frame: frame)
        setupConstraints ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints () {
        
        let nameAndAgeStackView = UIStackView(firstView: label, secondView: textField, verticalSpacing: 4)
        self.addSubview(nameAndAgeStackView)
        
        nameAndAgeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .white
        self.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
        
        NSLayoutConstraint.activate([
            nameAndAgeStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            nameAndAgeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            nameAndAgeStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameAndAgeStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
        ])
    }
}
