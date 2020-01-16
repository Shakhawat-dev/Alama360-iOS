//
//  PropertyInfoWindow.swift
//  Alama360
//
//  Created by Alama360 on 21/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class PropertyInfoWindow: UIView {

    override init(frame: CGRect) {
     super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
    }
    func loadView() -> PropertyInfoWindow {
     let propertyInfoWindow = Bundle.main.loadNibNamed("PropertyInfoWindow", owner: self, options: nil)?[0] as! PropertyInfoWindow
     return propertyInfoWindow
    }

}
