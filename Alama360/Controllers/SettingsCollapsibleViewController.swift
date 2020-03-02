//
//  SettingsCollapsibleViewController.swift
//  Alama360
//
//  Created by Alama360 on 07/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import CollapsibleTableSectionViewController

class SettingsCollapsibleViewController: CollapsibleTableSectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsCollapsibleViewController: CollapsibleTableSectionDelegate {
    
    func numberOfSections(_ tableView: UITableView) -> Int {
        return 5
    }
    
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InsuranceTableViewCell") as! InsuranceTableViewCell? ?? InsuranceTableViewCell(style: .default, reuseIdentifier: "InsuranceTableViewCell")
        
//        let item: Item = sections[(indexPath as NSIndexPath).section].items[(indexPath as NSIndexPath).row]
        
//        cell.nameLabel.text = item.name
//        cell.detailLabel.text = item.detail
        
        return cell
    }
    
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "hello"
    }
    
}
