//
//  UIStackView + Extensions.swift
//  SimpleConverter
//
//  Created by Денис Чупров on 27.04.2022.
//

import Foundation
import UIKit

extension UIStackView {
    
    convenience init(axis:NSLayoutConstraint.Axis, spacing: CGFloat, arrangedSubviews : [UIView]) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
        self.distribution = .fillEqually
    }
    
}
