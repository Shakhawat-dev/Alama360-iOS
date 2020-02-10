//
//  ReservationDetailsTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 15/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class ReservationDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var porpInfoContainerView: UIView!
    @IBOutlet weak var propertyThumb: UIImageView!
    @IBOutlet weak var propertyTitle: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var districtLbl: UILabel!
    @IBOutlet weak var sectionLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        porpInfoContainerView.layer.cornerRadius = 8
        porpInfoContainerView.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        porpInfoContainerView.layer.borderWidth = 1
        porpInfoContainerView.layer.shadowOffset = CGSize(width: 0.4, height: 0.4)
        porpInfoContainerView.layer.shadowRadius = 8
        porpInfoContainerView.layer.shadowColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //     For getting image from url
    func getImage(from string: String) -> UIImage? {
        
        //2. Get valid URL
        guard let url = URL(string: string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            
            else {
                print("Unable to create URL")
                return nil
        }
        
        var image: UIImage? = nil
        do {
            //3. Get valid data
            let data = try Data(contentsOf: url, options: [])
            
            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        
        return image
    }
    
    func setPropertyInfo(thumb: String, title: String, city: String, dist: String, man: Int, women: Int) {
        
        propertyThumb.image = getImage(from: thumb)
        propertyTitle.text = title
        cityLbl.text = city
        districtLbl.text = dist
        
        if man == 1 && women == 2 {
            sectionLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "man_women", comment: "").localiz()
        } else if man == 1 && women == 0 {
            sectionLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "man", comment: "").localiz()
        } else if man == 0 && women == 2 {
            sectionLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "women", comment: "").localiz()
        } else {
            sectionLbl.text = "--- -----"
        }
    }

}
