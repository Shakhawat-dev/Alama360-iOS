//
//  Property360Cell.swift
//  Alama360
//
//  Created by Alama360 on 12/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import WebKit

class Property360Cell: UITableViewCell {
//    StaticUrls.WEB_360_VIEW_URL
    var url: String = ""

    @IBOutlet weak var property360WkView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        get360View()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // For 360 property View
    func get360View(url: String) {
        if url != "" {
            let myURL = URL(string: url)
            print("360 view url: \(url)")
            let myRequest = URLRequest(url: myURL!)
            self.property360WkView.load(myRequest)
            
            self.property360WkView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading" {
            if property360WkView.isLoading {
                activityIndicator.startAnimating()
                activityIndicator.isHidden = false
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }

}
