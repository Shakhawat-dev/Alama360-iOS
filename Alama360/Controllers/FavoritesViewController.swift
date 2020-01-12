//
//  FavoritesViewController.swift
//  Alama360
//
//  Created by Alama360 on 12/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import DatePickerDialog
import ImageSlideshow

class FavoritesViewController: UIViewController {


    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var dummyImage: UIImageView!
    @IBOutlet weak var dummyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSlideShow()
        datePickerTapped()

        // Do any additional setup after loading the view.
    }
    
    func datePickerTapped() {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MM/dd/yyyy"
                        self.dummyLabel.text = formatter.string(from: dt)
                    }
        }
    }
    
    func imageSlideShow() {

            slideShow.setImageInputs([
                ImageSource(image: UIImage(named: "alama_logo")!),
                ImageSource(image: UIImage(named: "alama_logo")!),
//          AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080"),
          
        ])
        
    }
    
}
