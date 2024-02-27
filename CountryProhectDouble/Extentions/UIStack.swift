//
//  UIStack.swift
//  Test4RedpeadTest1
//
//  Created by Богдан Бончев on 26.02.2024.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment ){
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
