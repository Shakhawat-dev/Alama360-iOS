//
//  addPropertyTermsViewController.swift
//  Alama360
//
//  Created by Alama360 on 20/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class addPropertyTermsViewController: UIViewController {

    @IBOutlet weak var checkBoxBtn: UIView!
    @IBOutlet weak var dummyTetx: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }

        dummyTetx.text = "ksbgksbgkbsdkjbgkwbeiukjdskskjngjrnkjjfdkhgdhgiuhduhiudhtuitgijfgfouhguhfguhofgjkgjflkjglkjlfkgjoijfgijijiogfjoijtrjlkglkjfijtlfjlgoijrtjlgkfjoitrhuhtdiuhtiuhuikjhdfhoshenfovdonoitnoinoitorjoinoivnoirtnlkfmijtojvnortoittttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttht"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkBoxClicked(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
        /*if sender.isSelected {
           sender.isSelected = false
        } else {
            sender.isSelected  = true
        }*/
        
    }
    

}
