//
//  PropertyDetailsViewController.swift
//  Alama360
//
//  Created by Alama360 on 29/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class PropertyDetailsViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var property360View: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var propertyWKview: WKWebView!
    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var districtName: UILabel!
    
    @IBOutlet weak var thumbOne: UIImageView!
    @IBOutlet weak var thumbTwo: UIImageView!
    @IBOutlet weak var thumbThree: UIImageView!
    @IBOutlet weak var thumbFour: UIImageView!
    @IBOutlet weak var thumbFive: UIImageView!
    @IBOutlet weak var textTransparentView: UIView!
    @IBOutlet weak var shortDesc: UILabel!
    
    @IBOutlet weak var youtubeWebView: UIView!
    @IBOutlet weak var youtubeWkView: WKWebView!
    
    @IBOutlet weak var featuresTableView: UITableView!
    
    let url: String = StaticUrls.WEB_360_VIEW_URL
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        get360View()
        getPropertyDetails()
        
//       var frame = featuresTableView.frame
//       frame.size.height = featuresTableView.contentSize.height
//       featuresTableView.frame = frame
        
    }
    
    // For 360 property View
    func get360View() {
        let myURL = URL(string: url)
        print("360 view url: \(url)")
        let myRequest = URLRequest(url: myURL!)
        self.propertyWKview.load(myRequest)
        
        self.propertyWKview.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading" {
            if propertyWKview.isLoading {
                activityIndicator.startAnimating()
                activityIndicator.isHidden = false
            } else {
                activityIndicator.stopAnimating()
            }
        }
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

                self.setValues()
                self.getYoutubeVideo()

                self.featuresTableView.delegate = self
                self.featuresTableView.dataSource = self
                self.featuresTableView.reloadData()
            
                self.featuresTableView.layoutIfNeeded()
                self.featuresTableView.heightAnchor.constraint(equalToConstant: self.featuresTableView.contentSize.height).isActive = true
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
    
    func setValues() {
        
        let imageOne = photos?.picture[0]
        let imageTwo = photos?.picture[1]
        let imageThree = photos?.picture[2]
        let imageFour = photos?.picture[3]
        let imageFive = photos?.picture[4]
        
        propertyName.text = self.pTitle
        cityName.text = self.pCityname
        thumbOne.image =  getImage(from: imageOne!)
        thumbTwo.image =  getImage(from: imageTwo!)
        thumbThree.image =  getImage(from: imageThree!)
        thumbFour.image =  getImage(from: imageFour!)
        thumbFive.image =  getImage(from: imageFive!)
        districtName.text = self.pDistName
        shortDesc.text = self.pShort_des

        textTransparentView.layer.opacity = 0.5

    }
    
    func getYoutubeVideo() {
        let myURL = URL(string: pYoutube_video_url!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        print("360 view url: \(pYoutube_video_url)")
        let myRequest = URLRequest(url: myURL!)
        self.youtubeWkView.load(myRequest)
        
        self.youtubeWkView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }
    
    // Removing unwanted charecters
    func substringIcon (text: String) ->String {
        
        let  i_text = text
        var mySubstring: String = ""
        
        if i_text != "" {
            let start = i_text.index(i_text.startIndex, offsetBy: 10)
            let end = i_text.index(i_text.endIndex, offsetBy: -2)
            let range = start..<end
            
            mySubstring = i_text[range].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            // print("SUBSTRING is: \(mySubstring)")
            
        } else {
            mySubstring = "https://png.icons8.com/metro/30/000000/parking.png"
        }
        
        return mySubstring
        
    }
    
    
}

extension PropertyDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((property_dailyfeature?.col1_array.count)!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "featureCell", for: indexPath) as! FeatureTableViewCell
        
        
        
        if let feature_array: [String] = property_dailyfeature?.col1_array {
            ///print("individual : \(feature_array)")
            cell.featureLabel.text = feature_array[indexPath.row]
        }
        
        if let icon_array: [String] = property_dailyfeature?.icon_array{
            let icon  = substringIcon(text: icon_array[indexPath.row])
            cell.featureImage.image = getImage(from: icon)
        }
        
        return cell
    }
    
}
