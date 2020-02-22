//
//  OwnerPropertyViewController.swift
//  Alama360
//
//  Created by Alama360 on 19/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import LanguageManager_iOS
import AlamofireImage
import ImageSlideshow

class OwnerPropertyViewController: UIViewController {
    
    @IBOutlet weak var ownerPropertyTableView: UITableView!
    
    let defaults = UserDefaults.standard
    var lan: String = ""
    var userId: String = ""
    var id: String = ""
    var mobile: String = ""
    
    private var f_col = [String]()
    var property_list = [BookingModel]()
    var arrrFeatures = [FeatureModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light //For light mode
        
        userId = defaults.string(forKey: "userID") ?? ""
        mobile = defaults.string(forKey: "phoneNumber") ?? ""
        
        getProperties()
    }
    
    // Load Booking List
    func getProperties() {
        SVProgressHUD.show()
        
        self.ownerPropertyTableView.delegate = self
        self.ownerPropertyTableView.dataSource = self
        
        lan = LanguageManager.shared.currentLanguage.rawValue
        //        android/propertylist?lang=en&userid=124&ads_by=124
        let bUrl = StaticUrls.BASE_URL_FINAL + "android/propertylist?lang=\(lan)&userid=\(id)&ads_by=\(id)"
        
        // URL check
        //         print("Response bUrl is: \(bUrl)" + "\(params)")
        
        Alamofire.request(bUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                //                 print(resultArray as Any)
                
                // Initiatoing resultArray into specific array
                for i in resultArray.arrayValue {
                    
                    let newProperty = BookingModel(json: i)
                    
                    self.property_list.append(newProperty)
                    
                    
                    
                    // print(self.property_list)
                    
                }
                
                DispatchQueue.main.async {
                    self.ownerPropertyTableView.reloadData()
                    SVProgressHUD.dismiss()
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
        if segue.identifier == "ownerListToPD" {
            let destVC = segue.destination as! TbPropertyDetailsViewController
            destVC.id = sender as? String
        }
        
        if segue.identifier == "ownerlListToWeb" {
            let destVC = segue.destination as! OwnerWebViewController
            destVC.url = sender as? String ?? ""
        }
    }
    
}

extension OwnerPropertyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return property_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerReservationTableViewCell", for: indexPath) as! OwnerReservationTableViewCell
        
        //        cell.contentView.layer.cornerRadius = 12
        
        
        cell.rowTitle.text = property_list[indexPath.row].title
        cell.tapDelegate = self
        cell.index = indexPath
        
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
            cell.totalDaysLbl.text = String(describing: property_list[indexPath.row].totalday!) + " Days"
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
                
                //                    let icon1  = substringIcon(text: icons_array[0])
                //                    let icon2  = substringIcon(text: icons_array[1])
                //                    let icon3  = substringIcon(text: icons_array[2])
                //
                //                    cell.featureImageOne.image = getImage(from: icon1)
                //                    cell.featureImageTwo.image = getImage(from: icon2)
                //                    cell.featureImageThree.image = getImage(from: icon3)
                //
                //                } else {
                //                    cell.featureImageOne.image = nil
                //                    cell.featureImageTwo.image = nil
                //                    cell.featureImageThree.image = nil
                //                }
                
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id = property_list[indexPath.row].id!
        performSegue(withIdentifier: "ownerListToPD", sender: id)
    }
    
    
    
}

extension OwnerPropertyViewController: OwnerSlideTapDelegate {
    func didTapSlideShow(index: Int) {
        id = property_list[index].id!
        performSegue(withIdentifier: "ownerListToPD", sender: id)
    }
    
    func didTapCalenderBtn(index: Int) {
        id = property_list[index].id!
        
        let url = StaticUrls.BASE_URL_FINAL + "owner/dashboard/" + id + "?userid=" + userId + "&lang=" + lan + "&mobile=" + mobile  + "&token=Ddhfkjdshgfjshgkjldsahgdniudhagiuashdfiughd&actiontype=updateproperty&propertyid=" + id + "&current_pid=" + id
        print("Calaender Url: \(url)")
        
        performSegue(withIdentifier: "ownerlListToWeb", sender: url)
    }
    
    func didTapPriceUpdateBtn(index: Int) {
        id = property_list[index].id!
        
        let url = StaticUrls.BASE_URL_FINAL + "change-your-property-price.html/" + id + "?userid=" + userId + "&lang=" + lan + "&mobile=" + mobile + "&token=Ddhfkjdshgfjshgkjldsahgdniudhagiuashdfiughd&actiontype=updateproperty&propertyid=" + id
        print("Price Update Url: \(url)")
        
        performSegue(withIdentifier: "ownerlListToWeb", sender: url)
    }
    
    func didTapSettingBtn(index: Int) {
        id = property_list[index].id!
        
        let url = StaticUrls.BASE_URL_FINAL + "updatepropertysettings.html/" + id + "?userid=" + userId + "&lang=" + lan + "&mobile=" + mobile  + "&token=Ddhfkjdshgfjshgkjldsahgdniudhagiuashdfiughd&actiontype=updateproperty&propertyid=" + id
        print("Settings Url: \(url)")
        
        performSegue(withIdentifier: "ownerlListToWeb", sender: url)
    }
    
    func didTapUploadPictureBtn(index: Int) {
        id = property_list[index].id!
        
        let url = StaticUrls.BASE_URL_FINAL + "upload-your-property-picture.html/" + id + "?userid=" + userId + "&lang=" + lan + "&mobile=" + mobile  + "&token=Ddhfkjdshgfjshgkjldsahgdniudhagiuashdfiughd&actiontype=updateproperty&propertyid=" + id
        print("Picture Update Url: \(url)")
        
        performSegue(withIdentifier: "ownerlListToWeb", sender: url)
    }
    
    
}
