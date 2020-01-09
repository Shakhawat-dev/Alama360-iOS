//
//  TermsOfUseViewController.swift
//  Alama360
//
//  Created by Alama360 on 14/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class TermsOfUseViewController: UIViewController {

    @IBOutlet weak var termsOfUseTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        termsOfUseTable.delegate = self
        termsOfUseTable.dataSource = self
    }

}

extension TermsOfUseViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: termsOfUseTable.frame.size.width, height: 18))
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) // Set your background color
        
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: termsOfUseTable.frame.size.width, height: 18))
        label.font = UIFont.systemFont(ofSize: 14)
        
        if section == 0 {
            label.text = "Terms and Conditions"
            view.addSubview(label)
            
            
            return view
        } else if section == 1 {
            label.text = "1. Copyright :"
            view.addSubview(label)
            
            return view
        }  else if section == 2 {
            label.text = "2. Trademarks :"
            view.addSubview(label)
            
            return view
        } else if section == 3 {
            label.text = "3. Limits of right of use :"
            view.addSubview(label)
            
            return view
        } else if section == 4 {
            label.text = "4. Use the site"
            view.addSubview(label)
            
            return view
        } else if section == 5 {
            label.text = "5. Credit card or bank transfer :"
            view.addSubview(label)
            
            return view
        }else if section == 6 {
            label.text = "6. Pre-payment, cancellation, non-attendance, and detailed conditions :"
            view.addSubview(label)
            
            return view
        }else if section == 7 {
            label.text = "7. DISCLAIMER AND LIMITATIONS OF LIABILITY :"
            view.addSubview(label)
            
            return view
        }else if section == 8 {
            label.text = "8. Use of information :"
            view.addSubview(label)
            
            return view
        }else if section == 9 {
            label.text = "9. Data :"
            view.addSubview(label)
            
            return view
        }else if section == 10 {
            label.text = "10. Privacy :"
            view.addSubview(label)
            
            return view
        }else if section == 11 {
            label.text = "11. Your account and password :"
            view.addSubview(label)
            
            return view
        }else if section == 12 {
            label.text = "12. Notices :"
            view.addSubview(label)
            
            return view
        }else if section == 13 {
            label.text = "13. Termination of contract :"
            view.addSubview(label)
            
            return view
        }else if section == 14 {
            label.text = "14. General Provisions :"
            view.addSubview(label)
            
            return view
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let row = indexPath.row
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: "TermsAndConditionsCell") as! TermsAndConditionsCell
        
        if section == 0 {

            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "terms_intro", comment: "")
            return cell
            
        } else if section == 1 {

            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Copyright", comment: "")
            return cell
            
        } else if section == 2 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Trademarks", comment: "")
            
            return cell
        } else if section == 3 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Limits", comment: "")
            
            return cell
        } else if section == 4 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Use_the_site", comment: "")
            
            return cell
        } else if section == 5 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Credit_card_or_bank_transfer", comment: "")
            
            return cell
        } else if section == 6 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Pre_payment", comment: "")
            
            return cell
        } else if section == 7 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "DISCLAIMER", comment: "")
            
            return cell
        } else if section == 8 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Use_of_information", comment: "")
            
            return cell
        } else if section == 9 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Data", comment: "")
            
            return cell
        } else if section == 10 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Privacy", comment: "")
            
            return cell
        } else if section == 11 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "account_and_password", comment: "")
            
            return cell
        } else if section == 12 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Notices", comment: "")
            
            return cell
        } else if section == 13 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Termination", comment: "")
            
            return cell
        } else if section == 14 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "General_Provisions", comment: "")
            
            return cell
        }  else {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Trademarks", comment: "")
            
            return cell
        }
         
    }
    
    
}
