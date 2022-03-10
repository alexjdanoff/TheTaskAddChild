//
//  InsertableTextField.swift
//  Test from Alef Development
//
//  Created by Alexandru Jdanov on 27.02.2022.
//

import UIKit

class InsertableTextField: UITextField {
    
    private let textView = UITextField()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        self.font = .laoSangamMN15()
        self.layer.cornerRadius = 4
        textView.textColor = .lightGray
        textView.isUserInteractionEnabled = false
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: self.topAnchor),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -27)
        ])
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: 30, left: 15, bottom: 10, right: 15))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: UIEdgeInsets(top: 30, left: 15, bottom: 10, right: 15))
    }
    
    convenience init(placeholder: String, font: UIFont? = .laoSangamMN15()) {
        self.init()
        textView.text = placeholder
        textView.font = font
    }
}
