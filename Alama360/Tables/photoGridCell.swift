//
//  PhotoGridCell.swift
//  Alama360
//
//  Created by Alama360 on 12/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

protocol AllPhotoDelegate {
    func didTapMoreBtn()
}

class PhotoGridCell: UITableViewCell {

    @IBOutlet weak var thumbOne: UIImageView!
    @IBOutlet weak var thumbTwo: UIImageView!
    @IBOutlet weak var thumbThree: UIImageView!
    @IBOutlet weak var thumbFour: UIImageView!
    @IBOutlet weak var thumbFive: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    
    var delegate: AllPhotoDelegate?
    
    var allPhotos: PhotosModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code\
//        setValues()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func moreBtnTapped(_ sender: Any) {
        delegate?.didTapMoreBtn()
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
//    aPhotos: PhotosModel
    func setValues(aPhotos: PhotosModel) {

        allPhotos = aPhotos

        let imageOne = allPhotos!.picture[0]
        let imageTwo = allPhotos!.picture[1]
        let imageThree = allPhotos!.picture[2]
        let imageFour = allPhotos!.picture[3]
        let imageFive = allPhotos!.picture[4]

        thumbOne.image =  getImage(from: imageOne!)
        thumbTwo.image =  getImage(from: imageTwo!)
        thumbThree.image =  getImage(from: imageThree!)
        thumbFour.image =  getImage(from: imageFour!)
        thumbFive.image =  getImage(from: imageFive!)

        moreButton.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "more", comment: "").localiz(),for: .normal)

        // Test Purpose

        // For 360 property View


//        let imageOne = aPhotos[0].picture
//        let imageTwo = aPhotos[1].picture
//        let imageThree = aPhotos[2].picture
//        let imageFour = aPhotos[3].picture
//        let imageFive = aPhotos[4].picture
//
//        thumbOne.image =  getImage(from: imageOne)
//        thumbTwo.image =  getImage(from: imageTwo)
//        thumbThree.image =  getImage(from: imageThree)
//        thumbFour.image =  getImage(from: imageFour)
//        thumbFive.image =  getImage(from: imageFive)
//
//        moreButton.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "more", comment: "").localiz(),for: .normal)

    }
}
