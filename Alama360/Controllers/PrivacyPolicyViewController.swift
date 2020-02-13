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
        overrideUserInterfaceStyle = .light //For light mode

        // Do any additional setup after loading the view.
        privacyTableView.delegate = self
        privacyTableView.dataSource = self
    }
    @IBAction func langBtnTapped(_ sender: Any) {
        
        let selectedLanguage: Languages = (sender as AnyObject).tag == 1 ? .en : .ar
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
        
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: privacyTableView.frame.size.width - 16, height: 18))
        label.font = UIFont.systemFont(ofSize: 14)
        
        if section == 0 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy2", comment: "").localiz()
            view.addSubview(label)
            
            
            return view
        } else if section == 1 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy4", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }  else if section == 2 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy6", comment: "").localiz()
            view.addSubview(label)
            
            return view
        } else if section == 3 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy8", comment: "").localiz()
            view.addSubview(label)
            
            return view
        } else if section == 4 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy10", comment: "").localiz()
            view.addSubview(label)
            
            return view
        } else if section == 5 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy12", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 6 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy14", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 7 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy16", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 8 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy18", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 9 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy20", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 10 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy22", comment: "").localiz()
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

            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy3", comment: "").localiz()
            return cell
            
        } else if section == 1 {

            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy5", comment: "").localiz()
            return cell
            
        } else if section == 2 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy7", comment: "").localiz()
            
            return cell
        } else if section == 3 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy9", comment: "").localiz()
            
            return cell
        } else if section == 4 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy11", comment: "").localiz()
            
            return cell
        } else if section == 5 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy13", comment: "").localiz()
            
            return cell
        } else if section == 6 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy15", comment: "").localiz()
            
            return cell
        } else if section == 7 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy17", comment: "").localiz()
            
            return cell
        } else if section == 8 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy19", comment: "").localiz()
            
            return cell
        } else if section == 9 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy21", comment: "").localiz()
            
            return cell
        } else if section == 10 {
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy23", comment: "").localiz()
            
            return cell
        } else{
            
            cell.privacyLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy24", comment: "").localiz()
            
            return cell
        }
    }
    
    
}
