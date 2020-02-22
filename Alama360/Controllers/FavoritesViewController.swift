//
//  FavoritesViewController.swift
//  Alama360
//
//  Created by Alama360 on 12/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import DatePickerDialog
import ImageSlideshow
import Alamofire
import SwiftyJSON
import LanguageManager_iOS

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favTable: UITableView!
    
    let defaults = UserDefaults.standard
    
    // Param Variables
    var startDate = ""
    var lan = ""
    var thumcate = ""
    var address = ""
    var id = ""
    
    var userId: String = ""
    
    private var f_col = [String]()
    var property_list = [BookingModel]()
    var arrrFeatures = [FeatureModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light //For light mode
        userId = defaults.string(forKey: "userID")!
        //        let logo = #imageLiteral(resourceName: "logo")
        //        let imageView = UIImageView(image:logo)
        //        self.navigationItem.titleView = imageView
        
        self.navigationItem.title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "favorites", comment: "").localiz()
        
        getPropertiesForDate()
        //        setLocalization()
    }
    
    // Load Booking List
    func getPropertiesForDate() {
        
        lan = LocalizationSystem.sharedInstance.getLanguage()
        //        let params : [String : String] = ["start" : "2019-12-19", "viewType" : "mapview", "lang" : lan, "thumbcat" : thumcate, "address" : address]
        
        let fUrl = StaticUrls.BASE_URL_FINAL + "androidfavorites?lang=\(lan)&userid=\(userId)"
        
        // URL check
        print("Fav bUrl is: \(fUrl)")
        
        Alamofire.request(fUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
//                print(mysresponse)
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                //                print(resultArray as Any)
                
                // Initiatoing resultArray into specific array
                for i in resultArray.arrayValue {
                    
                    let newProperty = BookingModel(json: i)
                    self.property_list.append(newProperty)
                    
                    self.favTable.delegate = self
                    self.favTable.dataSource = self
                    self.favTable.reloadData()
                    
                    // print(self.property_list)
                    
                }
                
            }
            
        }
        
    }
    
    // Removing unwanted charecters
    func substringIcon (text: String) ->String {
        
        let  i_text = text
        var mySubstring: String = ""
        
        if i_text != "" {
            let start = i_text.index(i_text.startIndex, offsetBy: 10)
            let end = i_text.index(i_text.endIndex, offsetBy: -2)
            let range = start..<end
            
            mySubstring = i_text[range].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            // print("SUBSTRING is: \(mySubstring)")
            
        } else {
            mySubstring = "https://png.icons8.com/metro/30/000000/parking.png"
        }
        
        return mySubstring
    }
    
    //     For getting image from url
    func getImage(from string: String) -> UIImage? {
        
        //2. Get valid URL
        guard let url = URL(string: string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            
            else {
                print("Unable to create URL")
                return nil
        }
        
        var image: UIImage? = nil
        do {
            //3. Get valid data
            let data = try Data(contentsOf: url, options: [])
            
            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        
        return image
    }
    
    // Sending Data to View COntroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFavDetails" {
            let destVC = segue.destination as! TbPropertyDetailsViewController
            destVC.id = (sender as? String)!
        }
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // let alertController = UIAlertController(title: "Selection", message: "Selected: \(currentDataSource[indexPath.row])", preferredStyle: .alert)
        
        // searchController.isActive = false
        
        // let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        // alertController.addAction(okAction)
        // present(alertController, animated: true, completion: nil)
        id = property_list[indexPath.row].id!
        performSegue(withIdentifier: "showFavDetails", sender: id)
        
    }
    
    func escape(string: String) -> String {
        let allowedCharacters = string.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: ":=\"#%/<>?@\\^`{|}").inverted) ?? ""
        return allowedCharacters
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Use Always current DataSource
        return property_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookingTableViewCell
        
        //        cell.contentView.layer.cornerRadius = 12
        
        cell.index = indexPath
        cell.tapDelegate = self
        cell.rowTitle.text = property_list[indexPath.row].title
        
        if property_list[indexPath.row].id != "" {
            cell.propertyId.text = "SA0" + property_list[indexPath.row].id!
        } else {
            cell.propertyId.text = "SA0"
        }
        
        if property_list[indexPath.row].districtname != "" {
            cell.rowCityName.text = property_list[indexPath.row].cityname! + ", " + property_list[indexPath.row].districtname!
        } else {
            cell.rowCityName.text = property_list[indexPath.row].cityname!
        }
        
        if property_list[indexPath.row].dayprice! > 0 {
            cell.rowDayPrice.text = String(describing: property_list[indexPath.row].dayprice!)
        } else {
            cell.rowDayPrice.text = ""
        }
        
        if property_list[indexPath.row].dayprice! > 0 {
            
            if property_list[indexPath.row].totalday! > 1 {
                cell.totalDaysLbl.text = String(describing: property_list[indexPath.row].totalday!) + " " + LocalizationSystem.sharedInstance.localizedStringForKey(key: "days", comment: "").localiz()
            } else {
                cell.totalDaysLbl.text = String(describing: property_list[indexPath.row].totalday!) + " " + LocalizationSystem.sharedInstance.localizedStringForKey(key: "day", comment: "").localiz()
            }
            
        } else {
            cell.totalDaysLbl.text = ""
        }
        
        // Adding images to slider
        if let photo_array: [String?] = property_list[indexPath.row].photos?.picture {
            
            cell.propertyRowSlideShow.setImageInputs([
                AlamofireSource(urlString: "https://alama360.com/lara/public/properties/\((property_list[indexPath.row].id)!)/photos/small/\(photo_array[0]!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!,
                AlamofireSource(urlString: "https://alama360.com/lara/public/properties/\((property_list[indexPath.row].id)!)/photos/small/\(photo_array[1]!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!,
                AlamofireSource(urlString: "https://alama360.com/lara/public/properties/\((property_list[indexPath.row].id)!)/photos/small/\(photo_array[2]!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!,
                AlamofireSource(urlString: "https://alama360.com/lara/public/properties/\((property_list[indexPath.row].id)!)/photos/small/\(photo_array[3]!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!,
                AlamofireSource(urlString: "https://alama360.com/lara/public/properties/\((property_list[indexPath.row].id)!)/photos/small/\(photo_array[4]!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
            ])
            
        }
        
        if let feature_array: [String] = property_list[indexPath.row].property_dailyfeature?.col1_array {
            
            // print("individual : \(feature_array)")
            
            if feature_array.count == 3 {
                cell.featureLabelOne.text = feature_array[0]
                cell.featureLabelTwo.text = feature_array[1]
                cell.featureLabelThree.text = feature_array[2]
            } else {
                cell.featureLabelOne.text = ""
                cell.featureLabelTwo.text = ""
                cell.featureLabelThree.text = ""
            }
            
        }
        
        if let icons_array: [String] = property_list[indexPath.row].property_dailyfeature?.icon_array {
            
            // print("individual : \(icons_array)")
            
            if icons_array.count == 3 {
                
                let icon1  = substringIcon(text: icons_array[0])
                let icon2  = substringIcon(text: icons_array[1])
                let icon3  = substringIcon(text: icons_array[2])
                
                //                    cell.featureImageOne.image = getImage(from: icon1)
                //                    cell.featureImageTwo.image = getImage(from: icon2)
                //                    cell.featureImageThree.image = getImage(from: icon3)
                
                cell.featureImageOne.af_setImage(withURL: URL(string: icon1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!)
                cell.featureImageTwo.af_setImage(withURL: URL(string: icon2.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!)
                cell.featureImageThree.af_setImage(withURL: URL(string: icon3.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!)
                
            } else {
                cell.featureImageOne.image = nil
                cell.featureImageTwo.image = nil
                cell.featureImageThree.image = nil
            }
            
        }
        
        return cell
    }
    
    
}
extension FavoritesViewController: SlideTapDelegate {
    func didTapSlideShow(index: Int) {
        id = property_list[index].id!
        performSegue(withIdentifier: "showFavDetails", sender: id)
    }
    
}
