//
//  CalcTotal.swift
//  Alama360
//
//  Created by Alama360 on 17/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation

class CalcTotal {
    func calcTotalPrice(price: [RentalPriceModel]) -> Int {
        var total: Int = 0
        for i in price {
            
            if i.availabity == "1" {
                total += Int(i.price!)!
            }
            
        }
        
        print("Total Price is: \(total)")
        return total
    }
}
