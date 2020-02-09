//
//  BookingTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 24/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import ImageSlideshow

protocol SlideTapDelegate {
    func didTapSlideShow(index: Int)
}

class BookingTableViewCell: UITableViewCell {
    @IBOutlet weak var propertyRowSlideShow: ImageSlideshow!
    @IBOutlet weak var propertyId: UILabel!
    @IBOutlet weak var rowTitle: UILabel!
    @IBOutlet weak var rowCityName: UILabel!
    @IBOutlet weak var rowDayPrice: UILabel!
    @IBOutlet weak var totalDaysLbl: UILabel!
    
    @IBOutlet weak var featureImageOne: UIImageView!
    @IBOutlet weak var featureImageTwo: UIImageView!
    @IBOutlet weak var featureImageThree: UIImageView!
    
    @IBOutlet weak var featureLabelOne: UILabel!
    @IBOutlet weak var featureLabelTwo: UILabel!
    @IBOutlet weak var featureLabelThree: UILabel!
    
    @IBOutlet weak var propertyIdVIew: UIView!
    @IBOutlet weak var rowContainerView: UIView!
    @IBOutlet weak var textAreaView: UIView!
    
    private var id = ""
    var tapDelegate: SlideTapDelegate?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
//        propertyRowSlideShow.layer.cornerRadius = 12
        propertyIdVIew.layer.cornerRadius = 12
        propertyRowSlideShow.contentScaleMode = .scaleAspectFill
        propertyRowSlideShow.slideshowInterval = 0  // 0 = off
        rowContainerView.layer.cornerRadius = 12
        rowContainerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        rowContainerView.layer.shadowOpacity = 0.3
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        propertyRowSlideShow.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func didTap() {
        tapDelegate?.didTapSlideShow(index: index!.row)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
