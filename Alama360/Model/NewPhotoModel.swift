//
//  newPhotoModel.swift
//  Alama360
//
//  Created by Alama360 on 24/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct NewPhotosModel {
    
    var picture: String = ""
    
    init() {
        
    }
    
    init(json: JSON) {
        
        picture = json["picture"].stringValue
        
    }
}
