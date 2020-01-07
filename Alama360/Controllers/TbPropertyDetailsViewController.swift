//
//  TbPropertyDetailsViewController.swift
//  Alama360
//
//  Created by Alama360 on 12/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class TbPropertyDetailsViewController: UIViewController {
    
    var lan: String = ""
    var userId: String = ""
    var id: String?

    var pTitle: String?
    var pCityname: String?
    var pDistName: String?
    var pShort_des: String?
    var pAddress: String?
    var pYoutube_video_url: String? = ""
    var photos: PhotosModel?
    var property_dailyfeature: FeatureModel?
    var landmark_arr = [String]()

    @IBOutlet weak var propertyDetailsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getPropertyDetails()

    }
    
    // Get Api Call
    func getPropertyDetails() {
        
        lan = LocalizationSystem.sharedInstance.getLanguage()
        
        let pdUrl = StaticUrls.BASE_URL_FINAL + "propertydetails/130?lang=en&userid=124"
        
        // URL check
        print("Response bUrl is: \(pdUrl)")
        
        Alamofire.request(pdUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                print(resultArray as Any)
                
                // Initiatoing resultArray into specific array
                
                
                self.pTitle = resultArray["title"].stringValue
                self.pCityname = resultArray["cityname"].stringValue
                self.pDistName = resultArray["dist_districtInfo"]["name"].stringValue
                self.pShort_des = resultArray["dist_districtInfo"]["description"].stringValue
                self.pYoutube_video_url = resultArray["youtube_video_url"].stringValue
                
                let photoArray = resultArray["photos"]["photosaall"].arrayValue
                let newPhoto = PhotosModel(json: JSON(photoArray))
                self.photos = newPhoto
                
                let featureArray = resultArray["property_dailyfeature"].arrayValue
                let newFeature = FeatureModel(json: JSON(featureArray))
                self.property_dailyfeature = newFeature

                print(self.property_dailyfeature)
                
                self.propertyDetailsTable.delegate = self
                self.propertyDetailsTable.dataSource = self
                self.propertyDetailsTable.reloadData()

                
//                self.setValues()
//                self.getYoutubeVideo()

            
//                self.featuresTableView.layoutIfNeeded()
//                self.featuresTableView.heightAnchor.constraint(equalToConstant: self.featuresTableView.contentSize.height).isActive = true
            }
            
        }
        
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


}

extension TbPropertyDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Property360Cell") as! Property360Cell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoGridCell") as! PhotoGridCell
            
            cell.setValues(tPhotos: photos!)
            
            return cell
        }
        
        
    }
    
    
}
