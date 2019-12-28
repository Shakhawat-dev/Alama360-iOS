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
    
    let url: String = StaticUrls.WEB_360_VIEW_URL
    var lan: String = ""
    var userId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        get360View()
        getPropertyDetails()
    }
    
    // For 360 property View
    func get360View() {
        let myURL = URL(string:"\(url)")
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
        
        let pdUrl = StaticUrls.BASE_URL_FINAL + "android/propertylist?"
        
        // URL check
        print("Response bUrl is: \(pdUrl)")
        
        Alamofire.request(pdUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                print(resultArray as Any)
                
                // Initiatoing resultArray into specific array
                for i in resultArray.arrayValue {
                    
                    let newProperty = BookingModel(json: i)
                    
                    // print(self.property_list)
                    
                }
                
            }
            
        }
        
    }
    
    
}
