//
//  YoutubeCell.swift
//  Alama360
//
//  Created by Alama360 on 12/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import WebKit

class YoutubeCell: UITableViewCell {
    
    let url: String = ""

    @IBOutlet weak var youtubeWkView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // For Youtube View
    func getYoutubeView(yUrl: String) {
        
        if yUrl != "" {

            let myURL = URL(string: yUrl)
            print("Youtube view url: \(url)")
            let myRequest = URLRequest(url: myURL!)
            self.youtubeWkView.load(myRequest)
            
            self.youtubeWkView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading" {
            if youtubeWkView.isLoading {
                activityIndicator.startAnimating()
                activityIndicator.isHidden = false
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }

}
