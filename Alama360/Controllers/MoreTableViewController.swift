//
//  MoreTableViewController.swift
//  Alama360
//
//  Created by Alama360 on 17/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController {

    @IBOutlet weak var myDetailsCell: UITableViewCell!
    @IBOutlet weak var faqCell: UITableViewCell!
    @IBOutlet weak var contactUsCell: UITableViewCell!
    @IBOutlet weak var inviteFriendCell: UITableViewCell!
    @IBOutlet weak var termsCell: UITableViewCell!
    @IBOutlet weak var privacyPolicyCell: UITableViewCell!
    @IBOutlet weak var ownerReservationCell: UITableViewCell!
    @IBOutlet weak var newPropertyCell: UITableViewCell!
    @IBOutlet weak var signOutCell: UITableViewCell!
    
    @IBOutlet weak var lblMyDetails: UILabel!
    @IBOutlet weak var lblFAQ: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblInvite: UILabel!
    @IBOutlet weak var lblTermsOfUse: UILabel!
    @IBOutlet weak var lblPrivacy: UILabel!
    @IBOutlet weak var lblOwnerReservations: UILabel!
    @IBOutlet weak var lblAddProperty: UILabel!
    @IBOutlet weak var lblSignOut: UILabel!
    
    //For storing user data
    let defaults = UserDefaults.standard
    var userType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        userType = defaults.string(forKey: "userType") ?? "user"
//        let logo = #imageLiteral(resourceName: "logo")
//        let imageView = UIImageView(image:logo)
        self.navigationItem.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "more", comment: "").localiz()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        lblMyDetails.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "my_details", comment: "").localiz()
        lblFAQ.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "faq", comment: "").localiz()
        lblContact.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "contact_us", comment: "").localiz()
        lblInvite.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "invite_friend", comment: "").localiz()
        lblTermsOfUse.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "terms_of_use", comment: "").localiz()
        lblPrivacy.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "privacy_policy", comment: "").localiz()
        lblOwnerReservations.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "owner_reservations", comment: "").localiz()
        lblAddProperty.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "lvl_add_property_menu", comment: "").localiz()
        lblSignOut.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "nav_sign_out", comment: "").localiz()
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight:CGFloat = 0.0
        if indexPath.row == 6 && userType == "user" {
            return rowHeight
        } else {
            return tableView.rowHeight
        }
//        return tableView.rowHeight
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cellUITableViewCell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 8 {
            
            let aTitle = LocalizationSystem.sharedInstance.localizedStringForKey(key: "sAlert_title", comment: "").localiz()
            let aMessage = LocalizationSystem.sharedInstance.localizedStringForKey(key: "sAlert_message", comment: "").localiz()
            let aOk = LocalizationSystem.sharedInstance.localizedStringForKey(key: "aAlert_ok", comment: "").localiz()
            let aCancel = LocalizationSystem.sharedInstance.localizedStringForKey(key: "sAlert_cancel", comment: "").localiz()
            
            let alert = UIAlertController(title: aTitle, message: aMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: aOk, style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                UserDefaults.standard.set(false, forKey: "loggedIn")
                Switcher.updateRootVC()
            }))
            alert.addAction(UIAlertAction(title: aCancel, style: .cancel, handler: { _ in
                NSLog("The \"Cancel\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            
//            Switcher.updateRootVC()
        }
    }

}
