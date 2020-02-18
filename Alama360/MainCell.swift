//
//  MainCell.swift
//  Alama360
//
//  Created by Alama360 on 15/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var cellContainerView: UIView!
    
    override func awakeFromNib() {
        cellContainerView.layer.cornerRadius = 8
        cellContainerView.layer.shadowRadius = 8
        cellContainerView.layer.shadowOpacity = 5.0
        cellContainerView.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        cellContainerView.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
}
