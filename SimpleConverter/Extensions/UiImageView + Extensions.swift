//
//  UiImageView + Extensions.swift
//  SimpleConverter
//
//  Created by Денис Чупров on 27.04.2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    func animateImage() {
            let shake = CABasicAnimation(keyPath: "position")
            shake.duration = 0.5
            shake.repeatCount = 100
            shake.autoreverses = true
        
        shake.fromValue = CGPoint(x: center.x , y: center.y - 2.5)
        shake.toValue = CGPoint(x: center.x  , y: center.y + 2.5)
            
            layer.add(shake, forKey: nil)
        
    }
    
    func rotationAnimation() {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.valueFunction = CAValueFunction(name: .rotateZ)
        animation.fromValue = 0
        animation.toValue = 2 * Float.pi
        animation.duration = 0.3
        layer.add(animation, forKey: nil)
    }
    
    func scaleAnimation() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.5
        animation.toValue = 1
        animation.duration = 2
        
       layer.add(animation, forKey: nil)
   }
    
}
