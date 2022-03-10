//
//  UIButton+Extension.swift
//  Test from Alef Development
//
//  Created by Alexandru Jdanov on 27.02.2022.
//

import UIKit

extension UIButton {
    
    convenience init(title: String,
                     titleColor: UIColor,
                     font: UIFont? = .laoSangamMN15(),
                     isBorder: Bool = true) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        
        if isBorder {
            
            let conteinerButtonView = UIView()
            
            conteinerButtonView.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(conteinerButtonView)
            conteinerButtonView.isUserInteractionEnabled = false
            
            conteinerButtonView.layer.cornerRadius = 22
            conteinerButtonView.layer.borderColor = self.titleLabel?.textColor.cgColor
            conteinerButtonView.layer.borderWidth = 2
            
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 45),
                self.widthAnchor.constraint(equalToConstant: 200)
            ])
            
            NSLayoutConstraint.activate([
                conteinerButtonView.topAnchor.constraint(equalTo: self.topAnchor),
                conteinerButtonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                conteinerButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 7),
                conteinerButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
    }
    
}
