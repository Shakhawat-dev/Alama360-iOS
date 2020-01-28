//
//  AddPropertyViewController.swift
//  Alama360
//
//  Created by Alama360 on 01/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import WebKit

class AddPropertyViewController: UIViewController {
    
    @IBOutlet weak var addPropertyWKView: WKWebView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    let defaults = UserDefaults.standard
    var lan: String = ""
    var userId: String = ""
    var phone: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        addProperty()
    }
    
    func addProperty() {
        
        userId = defaults.string(forKey: "userID")!
        lan = LocalizationSystem.sharedInstance.getLanguage()
        phone = defaults.string(forKey: "phoneNumber")!
        
        let addUrl = StaticUrls.ADD_PROPERTY_URL + "userid=\(userId)&lang=\(lan)&mobile=\(phone)&token=Ddhfkjdshgfjshgkjldsahgdniudhagiuashdfiughd&actiontype=addproperty"
        print("Add property url: \(addUrl)")
        
        let myURL = URL(string: addUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        let myRequest = URLRequest(url: myURL!)
        addPropertyWKView.load(myRequest)
        
        addPropertyWKView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading" {
            if addPropertyWKView.isLoading {
                loader.startAnimating()
                loader.isHidden = false
            } else {
                loader.stopAnimating()
            }
        }
    }
    
}
