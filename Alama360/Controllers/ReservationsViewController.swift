//
//  ReservationsViewController.swift
//  Alama360
//
//  Created by Alama360 on 12/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import SearchTextField

class ReservationsViewController: UIViewController{
    
    @IBOutlet weak var titleAuto: SearchTextField!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleAuto.filterStrings(["Red", "Blue", "Yellow"])
        
        
        
//        titleAuto.ACDelegate = self as? ACTextFieldDelegate
//
//        titleAuto.setAutoCompleteWith(DataSet: mdataSource)

        // Do any additional setup after loading the view.
    }
    
//    func ACTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        return true
//    }
    
    // Providing data source to get the suggestion from inputs
    

}
