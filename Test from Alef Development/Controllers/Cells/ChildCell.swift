//
//  ChildCell.swift
//  Test from Alef Development
//
//  Created by Alexandru Jdanov on 27.02.2022.
//

import UIKit

protocol ChildCellDelegate {
    func shouldDelete(at indexPath: IndexPath)
    func addNotification(at indexPath: IndexPath, child: Child)
}

class ChildCell: UITableViewCell {
    
    private let deleteChildButton = UIButton(title: "Удалить", titleColor: #colorLiteral(red: 0.004408729728, green: 0.6530340314, blue: 0.9960127473, alpha: 1), isBorder: false)
    let childNameTextField = InsertableTextField(placeholder: "Имя")
    let childAgeTextField = InsertableTextField(placeholder: "Возраст")
    
    var currentChild: Child?
    var delegate: ChildCellDelegate?
    var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        
        deleteChildButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        childNameTextField.addTarget(self, action: #selector(childNameAction), for: .editingDidEnd)
        childAgeTextField.addTarget(self, action: #selector(childAgeAction), for: .editingDidEnd)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc private func deleteButtonAction(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150)) {
            self.childNameTextField.text = ""
            self.childAgeTextField.text = ""
            self.contentView.endEditing(true)
            
            if self.delegate != nil, let indexPath = self.indexPath {
                self.delegate!.shouldDelete(at: indexPath)
            }
        }
    }
    
    @objc private func childNameAction(_ sender: UITextField) {
        if self.delegate != nil, let indexPath = indexPath, self.currentChild != nil {
            self.currentChild!.name = childNameTextField.text
            delegate!.addNotification(at: indexPath, child: self.currentChild!)
        }
    }
    
    @objc private func childAgeAction(_ sender: UITextField) {
        if self.delegate != nil, let indexPath = indexPath, self.currentChild != nil {
            if let ageInt = Int(childAgeTextField.text!) {
                self.currentChild!.age = ageInt
            }
            delegate!.addNotification(at: indexPath, child: self.currentChild!)
        }
    }
    
    func setupWith(child: Child) {
        self.currentChild = child
        if self.currentChild?.name == nil, self.currentChild?.age == nil {
            self.childNameTextField.text = ""
            self.childAgeTextField.text = ""
        }
        self.childNameTextField.text = self.currentChild?.name
        if self.currentChild?.age != nil {
            self.childAgeTextField.text = String( (self.currentChild?.age)! )
        } else if self.currentChild?.age == nil {
            self.childAgeTextField.text = ""
        }
    }
}

// MARK: - Setup constraints
extension ChildCell {
    private func setupConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [childNameTextField, childAgeTextField],
                                    axis: .vertical,
                                    spacing: 10)
        
        deleteChildButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(deleteChildButton)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: self.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(contentView.frame.width / 2) - 24),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            deleteChildButton.centerYAnchor.constraint(equalTo: childNameTextField.centerYAnchor),
            deleteChildButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20),
        ])
    }
}
