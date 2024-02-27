//
//  UIlabel.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 25.02.2024.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont!,textAlignment: NSTextAlignment){
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .black
        self.text = text
        self.font = font
        self.textAlignment = textAlignment
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = 0
    }
}

