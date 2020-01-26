//
//  CustomBtnGreen.swift
//  Alama360
//
//  Created by Alama360 on 30/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class CustomBtnGreen: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setRadiusAndShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setRadiusAndShadow()
    }
    
    func setRadiusAndShadow() {
    
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 8
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        
    }
    
}
