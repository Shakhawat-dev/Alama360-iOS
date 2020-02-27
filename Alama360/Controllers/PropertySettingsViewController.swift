//
//  PropertySettingsViewController.swift
//  Alama360
//
//  Created by Alama360 on 28/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import LanguageManager_iOS

struct ExpandCollapse {
    var isExpanded: Bool
    var rows: Int
}

class PropertySettingsViewController: UIViewController {
    
    @IBOutlet weak var sview: OwnerSettingsSectionHeader!
    @IBOutlet weak var ssview: UIView!
    @IBOutlet weak var propertySettingsTable: UITableView!
    let defaults = UserDefaults.standard
    let lan = LanguageManager.shared.currentLanguage.rawValue
    
    var bankArray = [BankCategoryModel]()
    var clientManagerArray = [ClientManagerModel]()
    var sectionBool: Bool = false
    
    var sectionArray = [ExpandCollapse(isExpanded: false, rows: 1),
                        ExpandCollapse(isExpanded: false, rows: 1),
                        ExpandCollapse(isExpanded: false, rows: 1),
                        ExpandCollapse(isExpanded: false, rows: 4),
                        ExpandCollapse(isExpanded: false, rows: 4)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        
        
        // Do any additional setup after loading the view.
        loadClientManager()
        loadBankCateory()
        
        propertySettingsTable.delegate = self
        propertySettingsTable.dataSource = self
    }
    
    func loadClientManager() {
        let nUrl = StaticUrls.BASE_URL_FINAL + "getclientmanager?lang=en&property_title=&slug=&property_id=130&userid=257&author_id=257"
        
        Alamofire.request(nUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                //                print(resultArray)
                for i in resultArray.arrayValue {
                    let manager = ClientManagerModel(json: i)
                    self.clientManagerArray.append(manager)
                }
                
                
            }
        }
    }
    
    func loadBankCateory() {
        
    }
    
}

extension PropertySettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = Bundle.main.loadNibNamed("OwnerSettingHeaderCell", owner: self, options: nil)?.first as! OwnerSettingHeaderCell
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: propertySettingsTable.frame.size.width, height: 40))
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // Set your background color

        let button = UIButton(type: .system)
        button.frame = CGRect(x: 8, y: 2, width: propertySettingsTable.frame.size.width - 16, height: 36)

//        let somespace: CGFloat = 10
        
//          self.myButton.setImage(UIImage(named: "cross"), forState: UIControlState.Normal)
//
//          self.myButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.myButton.frame.size.width - somespace , 0, 0)
//
//          print(self.myButton.imageView?.frame)
//
//          self.myButton.titleEdgeInsets = UIEdgeInsetsMake(0, (self.myButton.imageView?.frame.width)! + somespace, 0, 10 )
        
//        button.contentHorizontalAlignment = .left
        button.contentHorizontalAlignment = .leading
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.titleLabel?.textAlignment = .right
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "plus"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        button.semanticContentAttribute = UIApplication.shared
        .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        
//        button.imageEdgeInsets = UIEdgeInsets(top: 0,left: button.bounds.width - 38, bottom: 0, right: 0)
//        button.titleEdgeInsets = UIEdgeInsets(top: 0,left: -(button.imageView?.bounds.width)! + 8, bottom: 0, right: 0)
        button.imageEdgeInsets.left = 8
        button.titleEdgeInsets.left = 16
        headerCell.btnExpand.tag = section

        
        if section == 0 {
//            button.setTitle("1. Conditions of Reservation", for: .normal)
            headerCell.lblHeaderTitle.text = "1. Conditions of Reservation"
        } else if section == 1 {
//            button.setTitle("2. Cancellation and return policy", for: .normal)
            headerCell.lblHeaderTitle.text = "2. Cancellation and return policy"
        } else if section == 2 {
//            button.setTitle("3. Entry and departure hours", for: .normal)
            headerCell.lblHeaderTitle.text = "3. Entry and departure hours"
        } else if section == 3 {
//            button.setTitle("4. Book managers and messages SMS", for: .normal)
            headerCell.lblHeaderTitle.text = "4. Book managers and messages SMS"
        } else if section == 4 {
//            button.setTitle("5. Banks", for: .normal)
            headerCell.lblHeaderTitle.text = "5. Banks"
        }

        headerCell.btnExpand.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)

//        view.addSubview(button)
        
        return headerCell
    }
    
    @objc func handleExpandClose(button: UIButton) {
        print("Header Button Tapped \(button.tag)")
        
        let section = button.tag
        var indexPaths = [IndexPath]()
        
        
        let sectionStat = sectionArray[section].isExpanded
        sectionArray[section].isExpanded = !sectionStat
        
        if section == 0 || section == 1 || section == 2 {
            let indexPath = IndexPath(row: 0, section: section)
            indexPaths.append(indexPath)
        } else {
            for i in 0...3 {
                let indexPath = IndexPath(row: i, section: section)
                indexPaths.append(indexPath)
            }
        }
        
//        propertySettingsTable.reloadData()
        if sectionStat {
            propertySettingsTable.deleteRows(at: indexPaths, with: .fade)
        } else {
            propertySettingsTable.insertRows(at: indexPaths, with: .fade)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if section == 0 {
            if sectionArray[section].isExpanded == true {
                rows = 1
            } else {
                rows = 0
            }
            return rows
            
        } else if section == 1 {
            
            if sectionArray[section].isExpanded == true{
                rows = 1
            } else {
                rows = 0
            }
            return rows
            
        } else if section == 2 {
            
            if sectionArray[section].isExpanded == true {
                rows = 1
            } else {
                rows = 0
            }
            return rows
            
        } else if section == 3{
            if sectionArray[section].isExpanded == true {
                rows = 4
            } else {
                rows = 0
            }
            return rows
        } else if section == 4{
            if sectionArray[section].isExpanded == true {
                rows = 4
            } else {
                rows = 0
            }
            return rows
        } else {
            return rows
        }
  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        var cell: UITableViewCell?
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InsuranceTableViewCell", for: indexPath) as! InsuranceTableViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CancelationReturnTableViewCell", for: indexPath) as! CancelationReturnTableViewCell
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckInAndOutTableViewCell", for: indexPath) as! CheckInAndOutTableViewCell
            return cell
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonTableViewCell", for: indexPath) as! AddButtonTableViewCell
                return cell
            }
            
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookManagerTitleTableViewCell", for: indexPath) as! BookManagerTitleTableViewCell
                return cell
            }
            
            if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookManagerRowTableViewCell", for: indexPath) as! BookManagerRowTableViewCell
                return cell
            }
            
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookManagerDescTableViewCell", for: indexPath) as! BookManagerDescTableViewCell
                return cell
            }
            
        } else if indexPath.section == 4 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonTableViewCell", for: indexPath) as! AddButtonTableViewCell
                return cell
            }
            
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BankTitleTableViewCell", for: indexPath) as! BankTitleTableViewCell
                return cell
            }
            
            if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BankRowTableViewCell", for: indexPath) as! BankRowTableViewCell
                return cell
            }
            
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BankDescAndButtonTableViewCell", for: indexPath) as! BankDescAndButtonTableViewCell
                return cell
            }
            
        }
   
        return UITableViewCell()
    }
    
    
}
