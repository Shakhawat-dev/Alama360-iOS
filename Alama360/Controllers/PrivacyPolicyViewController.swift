//
//  PrivacyPolicyViewController.swift
//  Alama360
//
//  Created by Alama360 on 14/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import LanguageManager_iOS

class PrivacyPolicyViewController: UIViewController {

    @IBOutlet weak var privacyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        privacyTableView.delegate = self
        privacyTableView.dataSource = self
    }
    @IBAction func langBtnTapped(_ sender: Any) {
        
         // change the language
        LanguageManager.shared.setLanguage(language: .ar,
                                              viewControllerFactory: { title -> UIViewController in
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             // the view controller that you want to show after changing the language
             return storyboard.instantiateInitialViewController()!
           }) { view in
             view.transform = CGAffineTransform(scaleX: 2, y: 2)
             view.alpha = 0
           }
    }
    
}

extension PrivacyPolicyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: privacyTableView.frame.size.width, height: 18))
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) // Set your background color
        
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: privacyTableView.frame.size.width, height: 18))
        label.font = UIFont.systemFont(ofSize: 14)
        
        if section == 0 {
            label.text = "privacyTableView"
            view.addSubview(label)
            
            
            return view
        } else if section == 1 {
            label.text = "The data we collect"
            view.addSubview(label)
            
            return view
        }  else if section == 2 {
            label.text = "Other uses of your personal data"
            view.addSubview(label)
            
            return view
        } else if section == 3 {
            label.text = "We may send you"
            view.addSubview(label)
            
            return view
        } else if section == 4 {
            label.text = "Disclose your information"
            view.addSubview(label)
            
            return view
        } else if section == 5 {
            label.text = "Competitions"
            view.addSubview(label)
            
            return view
        }else if section == 6 {
            label.text = "No spam, spyware or impersonation"
            view.addSubview(label)
            
            return view
        }else if section == 7 {
            label.text = "Account Protection"
            view.addSubview(label)
            
            return view
        }else if section == 8 {
            label.text = "Cookies"
            view.addSubview(label)
            
            return view
        }else if section == 9 {
            label.text = "Protection"
            view.addSubview(label)
            
            return view
        }else if section == 10 {
            label.text = "Your rights"
            view.addSubview(label)
            
            return view
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrivacyPolicyCell") as! PrivacyPolicyCell
        
        if section == 0 {

            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Thank_you", comment: "").localiz()
            return cell
            
        } else if section == 1 {

            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "The_data_we_collect", comment: "").localiz()
            return cell
            
        } else if section == 2 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Other_uses", comment: "").localiz()
            
            return cell
        } else if section == 3 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "We_may_send_you", comment: "").localiz()
            
            return cell
        } else if section == 4 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Disclose_your_information", comment: "").localiz()
            
            return cell
        } else if section == 5 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Competitions", comment: "").localiz()
            
            return cell
        } else if section == 6 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "No_spam_spyware", comment: "").localiz()
            
            return cell
        } else if section == 7 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Cookies", comment: "").localiz()
            
            return cell
        } else if section == 8 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Protection", comment: "").localiz()
            
            return cell
        } else if section == 9 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Your_rights", comment: "")
            
            return cell
        } else{
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Generally_we", comment: "")
            
            return cell
        }
    }
    
    
}
