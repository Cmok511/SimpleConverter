//
//  UILabel + Extensions.swift
//  SimpleConverter
//
//  Created by Денис Чупров on 27.04.2022.
//

import Foundation
import UIKit


extension UILabel {
    
    
    
    
    convenience init(font: String, size: CGFloat, text: String) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .black
        self.font = UIFont(name: font, size: size)
        self.text = text
        self.textAlignment = .center
    }
    
    convenience init(size: CGFloat, text: String) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .black
        self.font = UIFont.systemFont(ofSize: size)
        self.text = text
        self.numberOfLines = 0
        self.textAlignment = .center
    }
    
    func scaleAnimation() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.5
        animation.toValue = 1
        animation.duration = 2
        
       layer.add(animation, forKey: nil)
   }
    
    
    func scaleAnimationTwo() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.duration = 1
        
       layer.add(animation, forKey: nil)
   }
    
    func rotationAnimation() {
        let animation = CABasicAnimation(keyPath: "transform")
        animation.valueFunction = CAValueFunction(name: .rotateZ)
        animation.fromValue = 0
        animation.toValue = 2 * Float.pi
        animation.duration = 0.3
        layer.add(animation, forKey: nil)
    }
    
    func shakeAnimation() {
            let shake = CABasicAnimation(keyPath: "position")
            shake.duration = 0.1
            shake.repeatCount = 1
            shake.autoreverses = false
        
        shake.fromValue = CGPoint(x: center.x , y: center.y )
        shake.toValue = CGPoint(x: center.x  , y: center.y + 2)
            
            layer.add(shake, forKey: nil)
        
    }
    
    
    
    
}
