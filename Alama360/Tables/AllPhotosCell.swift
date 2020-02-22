//
//  AllPhotosCell.swift
//  Alama360
//
//  Created by Alama360 on 13/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import AlamofireImage

class AllPhotosCell: UITableViewCell {

    @IBOutlet weak var cellPhoto: UIImageView!
    
//    var photos: PhotosModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImage(imageLink: String) {
        cellPhoto.af_setImage(withURL: URL(string: imageLink.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!)
    }

}
