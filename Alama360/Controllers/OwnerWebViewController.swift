//
//  OwnerWebViewController.swift
//  Alama360
//
//  Created by Alama360 on 19/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import WebKit

class OwnerWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        // Do any additional setup after loading the view.
        showWeb()
    }
    
    func showWeb() {
        
        let addUrl = url
        
        print("Add property url: \(addUrl)")
        
        let myURL = URL(string: addUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "loading" {
            if webView.isLoading {
                loader.startAnimating()
                loader.isHidden = false
            } else {
                loader.stopAnimating()
            }
        }
    }
}
