//
//  UIView + Extensions.swift
//  SimpleConverter
//
//  Created by Денис Чупров on 11.05.2022.
//

import Foundation
import UIKit


extension UIView {
    
    func scaleAnimationView() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.05
        animation.toValue = 1
        animation.duration = 2
        
       layer.add(animation, forKey: nil)
   }
}
