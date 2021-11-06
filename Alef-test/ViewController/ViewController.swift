//
//  ViewController.swift
//  Alef-test
//
//  Created by Рамил Гаджиев on 02.11.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    var childs:[ChildModel] = []
    var multiplier: CGFloat = 1
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
        return scrollView
    }()
    var titleLabel = UILabel(text: "Персональные данные", size: 20)
    var nameView = CustomView(frame: .zero, labelText: "Имя")
    var ageView = CustomView(frame: .zero, labelText: "Возраст", keyboardType: .numberPad)
    var childsLabel = UILabel(text: "Дети (макс. 5)", size: 20)
    var addChildButton = UIButton(text: "Добавить ребенка", color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.9843137255, blue: 0.9843137255, alpha: 1)
        tableView.isHidden = true
        tableView.register(ChildCell.self, forCellReuseIdentifier: ChildCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    var deleteAllInfo = UIButton(text: "Очистить", color: #colorLiteral(red: 0.730062887, green: 0.1491314173, blue: 0, alpha: 1))
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        nameView.textField.delegate = self
        ageView.textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        calculateMultiplier()
        setUpCell()
        addChildButton.addTarget(self, action: #selector(addChildButtonTapped), for: .touchUpInside)
        deleteAllInfo.addTarget(self, action: #selector(deleteAllInfoTapped), for: .touchUpInside)
        deleteAllInfo.isHidden = true
    }
    
    
    @objc func addChildButtonTapped () {
        deleteAllInfo.isHidden = false
        childs.append(ChildModel(name: "", age: ""))
        tableView.insertRows(at: [IndexPath(row: childs.count - 1, section: 0)], with: .right)
        tableView.isHidden = false
        let lastSectionIndex = self.tableView.numberOfRows(inSection: 0) - 1
        let pathToLastRow = IndexPath(row: lastSectionIndex, section: 0)
        self.tableView.scrollToRow(at: pathToLastRow, at: .top, animated: true)
        if childs.count == 5 {
            addChildButton.isHidden = true
        }
    }
    
    
    @objc func deleteAllInfoTapped  () {
        
        let actionSheet = UIAlertController(title: "Очистить все данные?", message: nil, preferredStyle: .actionSheet)
        let deleteAllInfoButton = UIAlertAction(title: "Сбросить данные", style: .default) { [weak self] _ in
            self?.nameView.textField.text = ""
            self?.ageView.textField.text = ""
            self?.childs = []
            self?.tableView.isHidden = true
            self?.deleteAllInfo.isHidden = true
            self?.addChildButton.isHidden = false
            self?.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheet.addAction(deleteAllInfoButton)
        actionSheet.addAction(cancelButton)
        present(actionSheet, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}


extension ViewController {
    
    func calculateMultiplier() {
        let viewHeight = UIScreen.main.bounds.height
        switch viewHeight {
        case 548.0...568.0:
            multiplier = 0.75
        case 647.0...667.0:
            multiplier = 0.8
        case 716.0...736.0:
            multiplier = 0.9
        case 780...812.0:
            multiplier = 0.95
        case 824...844.0:
            multiplier = 1
        case 876.0...926.0:
            multiplier = 1.05
        default: multiplier = 1
        }
    }
    
    func setUpCell() {
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        
        let nameAndAgeStackView = UIStackView(firstView: nameView, secondView: ageView, verticalSpacing: 10*multiplier)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        nameAndAgeStackView.translatesAutoresizingMaskIntoConstraints = false
        childsLabel.translatesAutoresizingMaskIntoConstraints = false
        addChildButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAllInfo.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        view.addSubview(nameAndAgeStackView)
        view.addSubview(childsLabel)
        view.addSubview(tableView)
        view.addSubview(addChildButton)
        view.addSubview(deleteAllInfo)
        
        NSLayoutConstraint.activate(
            [
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 70*multiplier),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                nameAndAgeStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30*multiplier),
                nameAndAgeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                nameAndAgeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                nameAndAgeStackView.heightAnchor.constraint(equalToConstant: 130*multiplier),
                
                childsLabel.topAnchor.constraint(equalTo: nameAndAgeStackView.bottomAnchor, constant: 30*multiplier),
                childsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                childsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
                
                addChildButton.centerYAnchor.constraint(equalTo: childsLabel.centerYAnchor),
                addChildButton.leadingAnchor.constraint(equalTo: childsLabel.trailingAnchor, constant: 20),
                addChildButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                addChildButton.heightAnchor.constraint(equalToConstant: 45*multiplier),
                
                tableView.topAnchor.constraint(equalTo: childsLabel.bottomAnchor, constant: 10),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                tableView.heightAnchor.constraint(equalToConstant: 312*multiplier),
                
                deleteAllInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                deleteAllInfo.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20*multiplier),
                deleteAllInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
                deleteAllInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
                deleteAllInfo.heightAnchor.constraint(equalToConstant: 45*multiplier)
            ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        childs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChildCell.identifier, for: indexPath)  as? ChildCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.delegate = self
        cell.childNameView.textField.text = childs[indexPath.row].name
        cell.childAgeView.textField.text = childs[indexPath.row].age
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156*multiplier
    }
}


extension ViewController: TableViewCellDelegate {
    
    
    func changeCellInfo(name: String, age: String, cell: ChildCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            childs[indexPath.row].name = name
            childs[indexPath.row].age = age
        }
    }
    
    
    func deleteChild(_ cell: ChildCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            DispatchQueue.main.async {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            self.childs.remove(at: indexPath.row)
            switch childs.count {
            case 0:
                tableView.isHidden = true
                deleteAllInfo.isHidden = true
            case 1...4:
                addChildButton.isHidden = false
            default:
                print("error")
            }
        }
    }
}


//MARK: - work with keyBoard appearence


extension ViewController {
    
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom:kbFrameSize.height , right: 0.0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height , right: 0)
    }
    
    @objc func kbDidHide() {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
