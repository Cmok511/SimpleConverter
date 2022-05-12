//
//  UIBatton+Extension.swift
//  SimpleConverter
//
//  Created by Денис Чупров on 25.04.2022.
//

import Foundation
import UIKit


extension UIButton {
    
     func scaleAnimation() {
         let animation = CASpringAnimation(keyPath: "transform.scale")
         animation.fromValue = 0.85
         animation.toValue = 1
         animation.duration = 1
        layer.add(animation, forKey: nil)
    }
    func scaleAnimationTwo() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.7
        animation.toValue = 1
        animation.duration = 1
        animation.damping = 0.1
       layer.add(animation, forKey: nil)
   }
    
    
    convenience init(title: String) {
        self.init(type: .system)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "Verdana", size: 30)
        self.backgroundColor = .systemGray5
        self.layer.cornerRadius = 20
       
       
    }
    
    
}
