//
//  ChildCell.swift
//  Alef-test
//
//  Created by Рамил Гаджиев on 03.11.2021.
//

import UIKit

protocol TableViewCellDelegate {
    func deleteChild(_ cell: ChildCell)
    func changeCellInfo(name: String, age: String, cell: ChildCell)
}

class ChildCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "childCell"
    
    var name: String = ""
    
    var age: String = ""
    
    
    var delegate: TableViewCellDelegate?
    
    var childNameView = CustomView(frame: .zero, labelText: "Имя")
    var childAgeView = CustomView(frame: .zero, labelText: "Возраст", keyboardType: .numberPad)
    
    var deleteChildButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.font = UIFont(name: "KohinoorBangla-Light", size: 16)
        button.setTitleColor(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        childNameView.textField.delegate = self
        childAgeView.textField.delegate = self
        contentView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
        contentView.addSubview(deleteChildButton)
        deleteChildButton.addTarget(self, action: #selector(deleteChildButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.changeCellInfo(name: childNameView.textField.text ?? "", age: childAgeView.textField.text ?? "", cell: self)
    }
    
    
    @objc func deleteChildButtonTapped() {
        delegate?.deleteChild(self)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let nameAndAgeStackView = UIStackView(firstView: childNameView, secondView: childAgeView, verticalSpacing: 8)
        
        
        nameAndAgeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(nameAndAgeStackView)
        
        
        NSLayoutConstraint.activate([
            nameAndAgeStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameAndAgeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameAndAgeStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            nameAndAgeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            deleteChildButton.centerYAnchor.constraint(equalTo: childNameView.centerYAnchor),
            deleteChildButton.leadingAnchor.constraint(equalTo: nameAndAgeStackView.trailingAnchor, constant: 10),
            deleteChildButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            deleteChildButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}


