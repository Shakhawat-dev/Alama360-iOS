//
//  PhotosModel.swift
//  Alama360
//
//  Created by Alama360 on 02/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PhotosModel {
    
    var picture = [String?]()
    
    init(json: JSON) {
        
        for i in json.arrayValue{
            var value: String?
            
            value = i["picture"].stringValue
            
            picture.append(value)
            
        }
        
        //        print("Picture array: \(picture)")
        
        //        print("ekhane pic paise \(picture)")
    }
}
