//
//  FAQViewController.swift
//  Alama360
//
//  Created by Alama360 on 16/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit


class FAQViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupManuBar()
    }
    
    let menubar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupManuBar() {
//        view = UIView(frame: CGRect(x: 0,y: (navigationController?.navigationBar.frame.height)!,width: 0,height: 50))
//        let mbView = UIView(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.height)!, width: UIScreen.main.bounds.width, height: 200))
        view.addSubview(menubar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menubar)
        view.addConstraintsWithFormat("V:|[v0(130)]|", views: menubar)
            
    }

}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

