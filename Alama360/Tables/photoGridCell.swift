//
//  PhotoGridCell.swift
//  Alama360
//
//  Created by Alama360 on 12/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

protocol AllPhotoDelegate {
//    func didTapMoreBtn(allphotos: PhotosModel)
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
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        super.setSelected(false, animated: false)
    }

    @IBAction func moreBtnTapped(_ sender: Any) {
//        delegate?.didTapMoreBtn(allphotos: allPhotos)
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
//    func setValues(aPhotos: PhotosModel) {
//
//        allPhotos = aPhotos
//
//        let imageOne = allPhotos!.picture[0]
//        let imageTwo = allPhotos!.picture[1]
//        let imageThree = allPhotos!.picture[2]
//        let imageFour = allPhotos!.picture[3]
//        let imageFive = allPhotos!.picture[4]
//
//        thumbOne.image =  getImage(from: imageOne!)
//        thumbTwo.image =  getImage(from: imageTwo!)
//        thumbThree.image =  getImage(from: imageThree!)
//        thumbFour.image =  getImage(from: imageFour!)
//        thumbFive.image =  getImage(from: imageFive!)
//
//        moreButton.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "more", comment: "").localiz(),for: .normal)
//
//    }
    
    func setValues(aPhotos: [String]) {

//        thumbOne.image =  getImage(from: aPhotos[0])
//        thumbTwo.image =  getImage(from: aPhotos[1])
//        thumbThree.image =  getImage(from: aPhotos[2])
//        thumbFour.image =  getImage(from: aPhotos[3])
//        thumbFive.image =  getImage(from: aPhotos[4])
        
        thumbOne.af_setImage(withURL: URL(string: aPhotos[0].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        thumbTwo.af_setImage(withURL: URL(string: aPhotos[1].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        thumbThree.af_setImage(withURL: URL(string: aPhotos[2].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        thumbFour.af_setImage(withURL: URL(string: aPhotos[3].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        thumbFive.af_setImage(withURL: URL(string: aPhotos[4].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        

        moreButton.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "more", comment: "").localiz(),for: .normal)

    }
}
