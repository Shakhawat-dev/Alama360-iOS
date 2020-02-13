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

        overrideUserInterfaceStyle = .light //For light mode
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
        
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: termsOfUseTable.frame.size.width - 16, height: 18))
        label.font = UIFont.systemFont(ofSize: 14)
        
        if section == 0 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "terms_title", comment: "").localiz()
            view.addSubview(label)
            
            
            return view
        } else if section == 1 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term2", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }  else if section == 2 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term4", comment: "").localiz()
            view.addSubview(label)
            
            return view
        } else if section == 3 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term6", comment: "").localiz()
            view.addSubview(label)
            
            return view
        } else if section == 4 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term8", comment: "").localiz()
            view.addSubview(label)
            
            return view
        } else if section == 5 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term10", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 6 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term12", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 7 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term14", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 8 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term16", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 9 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term18", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 10 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term20", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 11 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term22", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 12 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term24", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 13 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term26", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }else if section == 14 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term28", comment: "").localiz()
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

            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term1", comment: "").localiz()
            return cell
            
        } else if section == 1 {

            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term3", comment: "").localiz()
            return cell
            
        } else if section == 2 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term5", comment: "").localiz()
            
            return cell
        } else if section == 3 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term7", comment: "").localiz()
            
            return cell
        } else if section == 4 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term9", comment: "").localiz()
            
            return cell
        } else if section == 5 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term11", comment: "").localiz()
            
            return cell
        } else if section == 6 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term13", comment: "").localiz()
            
            return cell
        } else if section == 7 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term15", comment: "").localiz()
            
            return cell
        } else if section == 8 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term17", comment: "").localiz()
            
            return cell
        } else if section == 9 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term19", comment: "").localiz()
            
            return cell
        } else if section == 10 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term21", comment: "").localiz()
            
            return cell
        } else if section == 11 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term23", comment: "").localiz()
            
            return cell
        } else if section == 12 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term25", comment: "").localiz()
            
            return cell
        } else if section == 13 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term27", comment: "").localiz()
            
            return cell
        } else if section == 14 {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "term29", comment: "").localiz()
            
            return cell
        }  else {
            
            cell.introLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Trademarks", comment: "").localiz()
            
            return cell
        }
         
    }
    
    
}
