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
        cellContainerView.layer.cornerRadius = 12
        cellContainerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        cellContainerView.layer.shadowOpacity = 0.3
    }
    
}
