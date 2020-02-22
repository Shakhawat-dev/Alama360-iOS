//
//  OwnerReservationTableViewCell.swift
//  Alama360
//
//  Created by Alama360 on 19/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import ImageSlideshow

protocol OwnerSlideTapDelegate {
    func didTapSlideShow(index: Int)
    func didTapCalenderBtn(index: Int)
    func didTapPriceUpdateBtn(index: Int)
    func didTapSettingBtn(index: Int)
    func didTapUploadPictureBtn(index: Int)
}

class OwnerReservationTableViewCell: UITableViewCell {
    
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
    
    @IBOutlet weak var calenderBtn: UIButton!
    @IBOutlet weak var changePriceBtn: UIButton!
    @IBOutlet weak var uploadPictureBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    
    @IBOutlet weak var propertyIDStackView: UIStackView!
    
    private var id = ""
    var tapDelegate: OwnerSlideTapDelegate?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        propertyIdVIew.layer.cornerRadius = 12
        propertyRowSlideShow.contentScaleMode = .scaleAspectFill
        propertyRowSlideShow.slideshowInterval = 0  // 0 = off
        rowContainerView.layer.cornerRadius = 12
        rowContainerView.layer.shadowOffset = CGSize(width: 2, height: 2)
        rowContainerView.layer.shadowOpacity = 0.3
        
        propertyIDStackView.semanticContentAttribute = .forceLeftToRight
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
        propertyRowSlideShow.addGestureRecognizer(gestureRecognizer)
        
        setLocalization()
    }
    
    func setLocalization() {
        calenderBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "calendar", comment: "").localiz(), for: .normal)
        changePriceBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "change_price", comment: "").localiz(), for: .normal)
        uploadPictureBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "upload_picture", comment: "").localiz(), for: .normal)
        settingsBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "settings", comment: "").localiz(), for: .normal)
    }
    
    @objc func didTap() {
        tapDelegate?.didTapSlideShow(index: index!.row)
    }
    
    @IBAction func calenderTapped(_ sender: Any) {
        tapDelegate?.didTapCalenderBtn(index: index?.row ?? 0)
    }
    @IBAction func changePriceTapped(_ sender: Any) {
        tapDelegate?.didTapPriceUpdateBtn(index: index?.row ?? 0)
    }
    @IBAction func uploadPictureTapped(_ sender: Any) {
        tapDelegate?.didTapUploadPictureBtn(index: index?.row ?? 0)
    }
    @IBAction func settingsTapped(_ sender: Any) {
        tapDelegate?.didTapSettingBtn(index: index?.row ?? 0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


