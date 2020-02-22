//
//  FeatureCell.swift
//  Alama360
//
//  Created by Alama360 on 12/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import AlamofireImage

class FeatureCell: UITableViewCell {

    @IBOutlet weak var featureImage: UIImageView!
    @IBOutlet weak var featureName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Removing unwanted charecters
//    func substringIcon (text: String) ->String {
//        
//        let  i_text = text
//        var mySubstring: String = ""
//        
//        if i_text != "" {
//            let start = i_text.index(i_text.startIndex, offsetBy: 10)
//            let end = i_text.index(i_text.endIndex, offsetBy: -2)
//            let range = start..<end
//            
//            mySubstring = i_text[range].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            
//            // print("SUBSTRING is: \(mySubstring)")
//            
//        } else {
//            mySubstring = "https://png.icons8.com/metro/30/000000/parking.png"
//        }
//        
//        return mySubstring
//    }
    
  
    

}
