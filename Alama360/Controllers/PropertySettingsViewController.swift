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
import iOSDropDown

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
    var id: String = ""
    var userId: String = ""
    
    var bankArray = [BankModel]()
    var timeArray = [CategoryModel]()
    var clientManagerArray = [ClientManagerModel]()
    var sectionBool: Bool = false
    var sectionHeight: CGFloat = 40.0
    
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
        
        userId = defaults.string(forKey: "userID") ?? ""
        
        // Do any additional setup after loading the view.
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadClientManager()
        loadBankList()
        getTimes()
        propertySettingsTable.delegate = self
        propertySettingsTable.dataSource = self
        
    }
    
    func loadClientManager() {
        let nUrl = StaticUrls.BASE_URL_FINAL + "getclientmanager?lang=\(lan)&property_title=&slug=&property_id=\(id)&userid=\(userId)&author_id=\(userId)"
        
        
        Alamofire.request(nUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                self.clientManagerArray.removeAll()
                //                print(resultArray)
                for i in resultArray.arrayValue {
                    let manager = ClientManagerModel(json: i)
                    self.clientManagerArray.append(manager)
                }
                print(self.clientManagerArray)
                
                self.propertySettingsTable.reloadData()
            }
        }
    }
    
    func loadBankList() {
        let bUrl = StaticUrls.BASE_URL_FINAL + "getclientbank?lang=\(lan)&property_title=&slug=&property_id=\(id)&userid=\(userId)&author_id=\(userId)"
        
        
        Alamofire.request(bUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                self.bankArray.removeAll()
                //              print(resultArray)
                for i in resultArray.arrayValue {
                    let bank = BankModel(json: i)
                    self.bankArray.append(bank)
                }
                print(self.bankArray)
                self.propertySettingsTable.reloadData()
                
            }
        }
    }
    
    func getTimes() {
        let tUrl = StaticUrls.BASE_URL_FINAL + "getLookUpByCat/88?lang=\(lan)&limit=20"
        
        
        Alamofire.request(tUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
                self.timeArray.removeAll()
                //              print(resultArray)
                for i in resultArray.arrayValue {
                    let time = CategoryModel(json: i)
                    self.timeArray.append(time)
                }
                //                print(self.timeArray)
                self.propertySettingsTable.reloadData()
                
            }
        }
    }
    
    func deleteManager(index: IndexPath) {
        print(index.row - 2)
        let mId = clientManagerArray[index.row - 2].id
        let pId = clientManagerArray[index.row - 2].property_id
        
        let params : [String : String] = ["lang" : "en",
                                          "dataview": "delete",
                                          "property_title" : "",
                                          "slug" : "",
                                          "property_id" : pId,
                                          "userid" : userId,
                                          "author_id" : userId,
                                          "managerid" : mId]
        
        print(params)
        
        let mUrl = "\(StaticUrls.BASE_URL_FINAL)getsingleclientmanager?"
        
        Alamofire.request(mUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
                print(mysresponse)
                self.loadClientManager()
                
                //                    self.propertySettingsTable.reloadData()
            }
        }
    }
    
    func deleteBank(index: IndexPath) {
        print(index.row - 2)
        let bId = bankArray[index.row - 2].id
        let pId = id
        
        let params : [String : String] = ["lang" : "en",
                                          "dataview": "delete",
                                          "property_title" : "",
                                          "slug" : "",
                                          "property_id" : pId,
                                          "userid" : userId,
                                          "author_id" : userId,
                                          "bankid" : bId]
        
        print(params)
        
        let mUrl = "\(StaticUrls.BASE_URL_FINAL)getsingleclientbank?"
        
        Alamofire.request(mUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
                print(mysresponse)
                self.loadBankList()
                
                //                    self.propertySettingsTable.reloadData()
            }
        }
    }
    
    // Sending Data to View COntroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ownerSettingsToAddManager" {
            let destVC = segue.destination as! AddNewManagerViewController
            destVC.id = sender as? String ?? ""
        }
        
        if segue.identifier == "ownerSettingsToAddBank" {
            let destVC = segue.destination as! AddBankViewController
            destVC.id = sender as? String ?? ""
        }
    }
    
}



extension PropertySettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = Bundle.main.loadNibNamed("OwnerSettingHeaderCell", owner: self, options: nil)?.first as! OwnerSettingHeaderCell
        
        //        let view = UIView(frame: CGRect(x: 0, y: 0, width: propertySettingsTable.frame.size.width, height: 40))
        //        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // Set your background color
        //
        //        let button = UIButton(type: .system)
        //        button.frame = CGRect(x: 8, y: 2, width: propertySettingsTable.frame.size.width - 16, height: 36)
        
        //        let somespace: CGFloat = 10
        
        //          self.myButton.setImage(UIImage(named: "cross"), forState: UIControlState.Normal)
        //
        //          self.myButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.myButton.frame.size.width - somespace , 0, 0)
        //
        //          print(self.myButton.imageView?.frame)
        //
        //          self.myButton.titleEdgeInsets = UIEdgeInsetsMake(0, (self.myButton.imageView?.frame.width)! + somespace, 0, 10 )
        
        //        button.contentHorizontalAlignment = .left
        //        button.contentHorizontalAlignment = .leading
        //        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        button.layer.borderWidth = 1
        //        button.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        //        button.titleLabel?.textAlignment = .right
        //        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        //        if #available(iOS 13.0, *) {
        //            button.setImage(UIImage(systemName: "plus"), for: .normal)
        //        } else {
        //            // Fallback on earlier versions
        //        }
        //        button.semanticContentAttribute = UIApplication.shared
        //            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        
        //        button.imageEdgeInsets = UIEdgeInsets(top: 0,left: button.bounds.width - 38, bottom: 0, right: 0)
        //        button.titleEdgeInsets = UIEdgeInsets(top: 0,left: -(button.imageView?.bounds.width)! + 8, bottom: 0, right: 0)
        //        button.imageEdgeInsets.left = 8
        //        button.titleEdgeInsets.left = 16
        
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
        
        return headerCell.contentView
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
        } else if section == 3 {
            for i in 0 ... (clientManagerArray.count + 2) {
                let indexPath = IndexPath(row: i, section: section)
                indexPaths.append(indexPath)
            }
        } else if section == 4 {
            for i in 0...(bankArray.count + 2) {
                let indexPath = IndexPath(row: i, section: section)
                indexPaths.append(indexPath)
            }
        } else {
            return
        }
        
        //        propertySettingsTable.reloadData()
        if sectionStat {
            propertySettingsTable.deleteRows(at: indexPaths, with: .fade)
        } else {
            propertySettingsTable.insertRows(at: indexPaths, with: .fade)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeight
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
                rows = clientManagerArray.count + 3
            } else {
                rows = 0
            }
            return rows
        } else if section == 4{
            if sectionArray[section].isExpanded == true {
                rows = bankArray.count + 3
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
            
            cell.setTimes(time: timeArray)
            
            return cell
        } else if indexPath.section == 3 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonTableViewCell", for: indexPath) as! AddButtonTableViewCell
                
                cell.index = indexPath
                cell.delegate = self as? AddNewDelegate
                
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookManagerTitleTableViewCell", for: indexPath) as! BookManagerTitleTableViewCell
                return cell
            } else if indexPath.row == clientManagerArray.count + 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookManagerDescTableViewCell", for: indexPath) as! BookManagerDescTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BookManagerRowTableViewCell", for: indexPath) as! BookManagerRowTableViewCell
                
                cell.index = indexPath
                cell.delegate = self
                
                if clientManagerArray.isEmpty != true {
                    cell.setManagers(managers: clientManagerArray[indexPath.row - 2] )
                }
                
                return cell
            }
            
            
            
        } else if indexPath.section == 4 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonTableViewCell", for: indexPath) as! AddButtonTableViewCell
                
                cell.index = indexPath
                cell.delegate = self as? AddNewDelegate
                
                return cell
            } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BankTitleTableViewCell", for: indexPath) as! BankTitleTableViewCell
                return cell
            } else if indexPath.row == bankArray.count + 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BankDescAndButtonTableViewCell", for: indexPath) as! BankDescAndButtonTableViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BankRowTableViewCell", for: indexPath) as! BankRowTableViewCell
                
                cell.index = indexPath
                cell.delegate = self

                if bankArray.isEmpty != true {
                    cell.setBanks(bank: bankArray[indexPath.row - 2] )
                }
                
                return cell
            }
            
        }
        
        return UITableViewCell()
    }
    
    
}

extension PropertySettingsViewController: AddNewDelegate {
    func addNewBtnTapped(index: IndexPath) {
        if index.section == 3 {
            performSegue(withIdentifier: "ownerSettingsToAddManager", sender: id)
        }
        
        if index.section == 4 {
            performSegue(withIdentifier: "ownerSettingsToAddBank", sender: id)
        }
    }
    
}

extension PropertySettingsViewController: ManagerDelegate {
    func editBtnTapped(index: IndexPath) {
        performSegue(withIdentifier: "ownerSettingsToAddManager", sender: self)
    }

    func deleteBtnTapped(index: IndexPath) {
        let alert = UIAlertController(title: "Warning", message: "Do you want to delete this manager?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { _ in
            //                NSLog("The \"OK\" alert occured.")
            self.deleteManager(index: index)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            //                NSLog("The \"OK\" alert occured.")
        }))

        self.present(alert, animated: true, completion: nil)
    }


}

extension PropertySettingsViewController: BankDelegate {
    func bEditBtnTapped(index: IndexPath) {
        performSegue(withIdentifier: "ownerSettingsToAddBank", sender: self)
    }
    
    func bDeleteBtnTapped(index: IndexPath) {
        let alert = UIAlertController(title: "Warning", message: "Do you want to delete this Bank Account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { _ in
            //                NSLog("The \"OK\" alert occured.")
            self.deleteBank(index: index)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            //                NSLog("The \"OK\" alert occured.")
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    
}

