//
//  UILabel+Extension.swift
//  Test from Alef Development
//
//  Created by Alexandru Jdanov on 27.02.2022.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        
        self.text = text
        self.font = font
    }
    
}
