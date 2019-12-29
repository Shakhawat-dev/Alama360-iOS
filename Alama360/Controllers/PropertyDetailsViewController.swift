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
    
    @IBOutlet weak var youtubeWebView: UIView!
    @IBOutlet weak var youtubeWkView: WKWebView!
    
    let url: String = StaticUrls.WEB_360_VIEW_URL
    var lan: String = ""
    var userId: String = ""
    
    var id: String?
    
    
    var pTitle: String?
    var pCityname: String?
    var pName: String?
    var pShort_des: String?
    var pAddress: String?
    var pYoutube_video_url: String? = ""
    
    var photos: PhotosModel?
    var property_dailyfeature: FeatureModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        get360View()
        getPropertyDetails()
        
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
                self.pName = resultArray["dist_districtInfo"]["name"].stringValue
                self.pYoutube_video_url = resultArray["youtube_video_url"].stringValue
                let photoArray = resultArray["photos"]["photosaall"].arrayValue
                    let new = PhotosModel(json: JSON(photoArray))
                    self.photos = new
            
                 print(self.pYoutube_video_url)
                
                
                
                
                
                
                self.setValues()
                self.getYoutubeVideo()
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
        textTransparentView.layer.opacity = 0.5
        // Test Purpose
        
        // For 360 property View
        
        
        
    }
    
    func getYoutubeVideo() {
        let myURL = URL(string: pYoutube_video_url!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        print("360 view url: \(pYoutube_video_url)")
        let myRequest = URLRequest(url: myURL!)
        self.youtubeWkView.load(myRequest)
        
        self.youtubeWkView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }
    
    
}
