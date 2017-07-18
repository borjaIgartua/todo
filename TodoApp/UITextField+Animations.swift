//
//  UITextField+Animations.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 18/7/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit

extension UITextField {
    
    func animateError(_ error: Bool) {
        
        if error {
            let animation = CAKeyframeAnimation()
            animation.keyPath = "position.x"
            animation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
            animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
            animation.duration = 0.4
            animation.isAdditive = true
            
            self.layer.add(animation, forKey: "shake")
            
            self.layer.borderColor = UIColor.redError.cgColor
            self.layer.cornerRadius = 5
            self.layer.borderWidth = 1
            
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
