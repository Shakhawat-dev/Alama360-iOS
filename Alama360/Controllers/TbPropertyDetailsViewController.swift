//
//  TbPropertyDetailsViewController.swift
//  Alama360
//
//  Created by Alama360 on 12/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON
import GoogleMaps
import LanguageManager_iOS
import SVProgressHUD

class TbPropertyDetailsViewController: UIViewController {
    //For storing user data
    let defaults = UserDefaults.standard
    
    var pdParams: (id: String, startDate: String, endDate: String)?
    var startDate = ""
    var endDate = ""
    var lan: String = ""
    var userId: String = ""
    var id: String?
    
    var rCount: Int = 0
    var message: String = ""
    var status: String = ""
    var isFav: Bool = true
    var favorite_info: String = ""
    
    var thumbnail: String?
    var pTitle: String?
    var pCityname: String?
    var pDistName: String?
    var pShort_des: String?
    var pAddress: String?
    var pLatitude: Double?
    var pLongitude: Double?
    var tour: String?
    var building_sec_man: Int?
    var building_sec_wman: Int?
    var check_in_start: String = ""
    var check_out_start: String = ""
    var pYoutube_video_url: String?
    var photos: PhotosModel?
    //    var property_dailyfeature: FeatureModel?
    var property_dailyfeature = [NewFeatureModel]()
    var landmark_arr = [String]()
    //    var cellRowClass : [String: String] = ["" : ""]
    var cellRowClass = [String]()
    
    var rentsalPriceArray = [RentalPriceModel]()
    
    @IBOutlet weak var propertyDetailsTable: UITableView!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    @IBOutlet weak var reservationBtn: CustomBtnGreen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light //For light mode
        userId = defaults.string(forKey: "userID")!
        startDate = defaults.string(forKey: "firstDate")!
        endDate = defaults.string(forKey: "lastDate")!
        reservationBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "reserve", comment: "").localiz(),for: .normal)
        //        id = pdParams?.id
        //        startDate = pdParams!.startDate
        //        endDate = pdParams!.endDate  // May come nil if not selected...
        
        // Do any additional setup after loading the view.
        getPropertyDetails()
        getRentalPrice()
        
    }
    
    // Get Api Call
    func getPropertyDetails() {
        
        SVProgressHUD.show()
        
        print("Property ID is: \(id)")
        //        lan = LocalizationSystem.sharedInstance.getLanguage()
        lan = LanguageManager.shared.currentLanguage.rawValue
        let pdUrl = StaticUrls.BASE_URL_FINAL + "propertydetails/\(id!)?lang=\(lan)&userid=\(userId)"
        
        // URL check
        print("Response bUrl is: \(pdUrl)")
        
        Alamofire.request(pdUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            if mysresponse.result.isSuccess {
                
                self.propertyDetailsTable.delegate = self
                self.propertyDetailsTable.dataSource = self
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
//                print(resultArray as Any)
                
                // Initiating resultArray into specific array
                self.thumbnail = resultArray["thumbnail"].stringValue
                self.pTitle = resultArray["title"].stringValue
                self.pCityname = resultArray["cityname"].stringValue
                self.pDistName = resultArray["dist_districtInfo"]["name"].stringValue
                self.pShort_des = resultArray["dist_districtInfo"]["description"].stringValue
                self.tour = resultArray["tour"].stringValue
                self.pYoutube_video_url = resultArray["youtube_video_url"].stringValue
                self.pLatitude = resultArray["latitude"].doubleValue
                self.pLongitude = resultArray["longitude"].doubleValue
                self.building_sec_man = resultArray["event_property_info"][0]["building_sec_man"].intValue
                self.building_sec_wman = resultArray["event_property_info"][0]["building_sec_wman"].intValue
                self.check_in_start = resultArray["event_property_info"][0]["check_in_start"].stringValue
                self.check_out_start = resultArray["event_property_info"][0]["check_out_start"].stringValue
                
//                print("\(self.building_sec_man) \(self.building_sec_wman)")
                
                let fav = resultArray["favorite_info"].rawString()
                
                for i in resultArray["landmarks"].arrayValue {
                    let name = i["name"].stringValue
                    self.landmark_arr.append(name)
                }
                
                let photoArray = resultArray["photos"]["photosaall"].arrayValue
                let newPhoto = PhotosModel(json: JSON(photoArray))
                self.photos = newPhoto
                
                let featureArray = resultArray["property_dailyfeature"].arrayValue
                //                let newFeature = NewFeatureModel(json: JSON(featureArray))
                //                self.property_dailyfeature.append(newFeature)
                for i in featureArray {
                    let newFeature = NewFeatureModel(json: JSON(i))
                    self.property_dailyfeature.append(newFeature)
                }
                
                print("Favourite info is: \(fav)")
                if fav! == "null" {
                    //                    print("Favourite info is: \(fav!)")
                    self.isFav = false
                    let btnImage: UIImage = UIImage(systemName: "heart")!
                    self.favBtn.image = btnImage
                } else {
                    self.isFav = true
                    let btnImage: UIImage = UIImage(systemName: "heart.fill")!
                    self.favBtn.image = btnImage
                }
                
                self.propertyDetailsTable.delegate = self
                self.propertyDetailsTable.dataSource = self
                
                DispatchQueue.main.async {
                    self.propertyDetailsTable.reloadData()
                    SVProgressHUD.dismiss()
                }
                //                self.propertyDetailsTable.delegate = self
                //                self.propertyDetailsTable.dataSource = self
                //                self.propertyDetailsTable.reloadData()
                
                // To show map on Footer
                //                self.getMapView ()
                
            }
            
        }
        
    }
    
    
    
    func getRentalPrice() {
        
        lan = LanguageManager.shared.currentLanguage.rawValue
        
        let pdUrl = StaticUrls.BASE_URL_FINAL + "getandroiddailyrentalprice?lang=\(lan)&propertyid=\(id!)&startdate=\(startDate)&enddate=\(endDate)"
        
        // URL check
        print("Response bUrl is: \(pdUrl)")
        
        Alamofire.request(pdUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            if mysresponse.result.isSuccess {
                
                
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
//                print("Prperty Rental Price array is: \(resultArray)")
                for i in resultArray.arrayValue {
                    let rentalPrice = RentalPriceModel(json: i)
                    self.rentsalPriceArray.append(rentalPrice)
                }
                
                //                        print("Rental Array is: \(self.rentsalPriceArray)")
                
                self.propertyDetailsTable.delegate = self
                self.propertyDetailsTable.dataSource = self
                DispatchQueue.main.async {
                    self.propertyDetailsTable.reloadData()
                    SVProgressHUD.dismiss()
                }
                
                
            }
            
        }
        
    }
    
    @IBAction func resevationBtnTapped(_ sender: Any) {
        
        if rentsalPriceArray.isEmpty != true {
            let propParam = (title : pTitle, city : pCityname, district: pDistName, thumbnail: thumbnail, id: id, man: building_sec_man, women: building_sec_wman, checkinTime: check_in_start, checkOutTime: check_out_start)
            print("property Param is : \(propParam)")
            performSegue(withIdentifier: "pdToRd", sender: propParam)
        } else {
            let aTitle = LocalizationSystem.sharedInstance.localizedStringForKey(key: "rAlertTitle", comment: "").localiz()
            let aMessage = LocalizationSystem.sharedInstance.localizedStringForKey(key: "rAlertMessage", comment: "").localiz()
            let aAction = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cOk", comment: "").localiz()
            
            let alert = UIAlertController(title: aTitle, message: aMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: aAction, style: .default, handler: { _ in
                //                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func favoriteBtnTapped(_ sender: Any) {
        let lan = LanguageManager.shared.currentLanguage.rawValue
        //        let user = defaults.string(forKey: "userID")!
        print("User ID is: \(userId)")
        
        let params : [String : String] = ["lang" : lan, "userid" : userId, "property_id" : id!]
        let fUrl = StaticUrls.BASE_URL_FINAL + "togglefavorites?"
        
        Alamofire.request(fUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult![]
                
//                print("Favorites response \(resultArray)")
                
                self.message = resultArray["message"].stringValue
                self.status = resultArray["status"].stringValue
                
                print("Status is: \(self.status)")
                print("Message is: \(self.message)")
                
                if self.status == "1" {
                    self.favSet()
                }
                
            }
        }
    }
    
    func favSet() {
        if self.isFav {
            self.isFav = false
            let btnImage:UIImage = UIImage(systemName: "heart")!
            //                    self.favBtn.setBackgroundImage(btnImage, for: .normal, style: .plain, barMetrics: .default)
            self.favBtn.image = btnImage
        } else {
            self.isFav = true
            let btnImage: UIImage = UIImage(systemName: "heart.fill")!
            //                    self.favBtn.setBackgroundImage(btnImage, for: .normal, style: .plain, barMetrics: .default)
            self.favBtn.image = btnImage
        }
    }
    
    
    //    func getMapView () {
    //
    //        GMSServices.provideAPIKey("AIzaSyDod0SP5Eh_eZmNNES7aTJt3eXs1mooFHY")
    //
    //        let camera = GMSCameraPosition.camera(withLatitude: pLatitude!, longitude: pLongitude!, zoom: 10.0)
    //        let mapView = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250), camera: camera)
    //
    //        // Using map as footerview
    //        propertyDetailsTable.tableFooterView = mapView
    //
    //        // Creates a marker in the center of the map.
    //        let marker = GMSMarker()
    //        marker.position = CLLocationCoordinate2D(latitude: pLatitude!, longitude: pLongitude!)
    //        marker.title = pTitle
    //        marker.snippet = pCityname
    //        marker.icon = #imageLiteral(resourceName: "marker_2")
    //        marker.map = mapView
    //
    //        mapView.selectedMarker = marker
    //    }
    
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
        if segue.identifier == "allPhotoSegue" {
            let destVC = segue.destination as! AllPhotosViewController
            destVC.id = sender as? String
        }
        if segue.identifier == "pdToRd" {
            let destVC = segue.destination as! ReservationDetailsViewController
            destVC.rdParams = sender as? (title: String, city: String, district: String, thumbnail: String, id: String, man: Int, women: Int, checkinTime: String, checkOutTime: String)
        }
    }
    
}

extension TbPropertyDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 4
        } else if section == 1{
            return 1
        } else if section == 2{
            return property_dailyfeature.count
        } else if section == 3 {
            return landmark_arr.count
        } else if section == 4{
            return 1
        } else if section == 5{
            return 1
        } else if section == 6{
//            print(rentsalPriceArray.count)
            return rentsalPriceArray.count
        } else if section == 7 {
            return 1
        } else {
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: propertyDetailsTable.frame.size.width, height: 18))
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) // Set your background color
        
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: propertyDetailsTable.frame.size.width - 16, height: 18))
        label.font = UIFont.systemFont(ofSize: 14)
        
        if section == 0 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "property", comment: "").localiz()
            view.addSubview(label)
            
            return view
        } else if section == 1  {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "description", comment: "").localiz()
            view.addSubview(label)
            
            return view
        }  else if section == 2 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "features", comment: "").localiz()
            view.addSubview(label)
            
            return view
        } else if section == 3 {
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "landmarks", comment: "").localiz()
            view.addSubview(label)
            
            return view
        } else if section == 4 {
            label.text = "Maps"
            view.addSubview(label)
            
            return view
        } else if section == 6 {
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: propertyDetailsTable.frame.size.width, height: 0))
            view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) // Set your background color
            let label = UILabel(frame: CGRect(x: 10, y: 5, width: propertyDetailsTable.frame.size.width - 16, height: 0))
            
            return nil
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 4 {
            return 0
        } else if section == 5 {
            return 0
        } else if section == 6 {
            return 0
        } else if section == 7 {
            return 0
        }
        
        return tableView.sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var rowHeight:CGFloat = 0.0
        //        let frame = tableView.rectForRow(at: indexPath)
        if indexPath.row == 0 && indexPath.section == 0 {
            if tour == "" {
                rowHeight = 0.0
            } else {
                rowHeight = tableView.rowHeight
            }
            return rowHeight
            
        } else if indexPath.row == 1 && indexPath.section == 0 {
            
            if photos?.picture[0] == "" {
                rowHeight = 0.0
            } else {
                rowHeight = tableView.rowHeight
            }
            return rowHeight
            
        } else if indexPath.row == 2 && indexPath.section == 0 {
            
            if pYoutube_video_url == "" {
                rowHeight = 0.0
            } else {
                rowHeight = tableView.rowHeight
            }
            return rowHeight
            
        } else if indexPath.section == 5 {
            
            if rentsalPriceArray.count == 0 {
                rowHeight = 0.0
            } else {
                rowHeight = tableView.rowHeight
            }
            return rowHeight
            
        } else {
            
            rowHeight = tableView.rowHeight
            
            return rowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let section = indexPath.section
        
        if section == 0 && row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Property360Cell") as! Property360Cell
            if tour != nil {
                cell.get360View(url: tour!)
                print("360 view url: \(tour)")
            }
            return cell
            
        } else if section == 0 && row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoGridCell") as! PhotoGridCell
            if let pp = photos?.picture {
                
                cell.setValues(aPhotos: photos!)
                cell.delegate = self
                
                return cell
            }
            
            return cell
            
        } else if section == 0 && row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YoutubeCell") as! YoutubeCell
            if pYoutube_video_url != nil {
                cell.getYoutubeView(yUrl: pYoutube_video_url!)
            }
            
            return cell
            
        } else if section == 0 && row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NamePolicyCell") as! NamePolicyCell
            
            cell.setNamePolicy(title: pTitle ?? "", city: pCityname ?? "", dist: pDistName ?? "", man: building_sec_man ?? 0, women: building_sec_wman ?? 0)
            
            return cell
            
        } else if section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PdDescriptionCell") as! PdDescriptionCell
            cell.pDescription.text = pShort_des
            
            return cell
            
        }  else if section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureCell") as! FeatureCell
            cell.featureName.text = property_dailyfeature[indexPath.row].col1
            cell.featureImage.image = getImage(from: substringIcon(text: property_dailyfeature[indexPath.row].icon))
            
            return cell
            
        } else if section == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "LandmarkCell") as! LandmarkCell
            cell.landmarkName.text = landmark_arr[indexPath.row]
            
            return cell
            
        } else if section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyMapCell") as! PropertyMapCell
            
            cell.getMapValues(lat: pLatitude ?? 0, longi: pLongitude ?? 0, title: pTitle ?? "", cityName: pCityname ?? "")
            
            return cell
            
        } else if section == 5 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateAvailabilityTitleTableViewCell") as! DateAvailabilityTitleTableViewCell
            
            return cell
            
        } else if section == 6 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateAvailabilityTableViewCell") as! DateAvailabilityTableViewCell
            cell.setValues(rentalPrices: rentsalPriceArray[indexPath.row])
            
            return cell
            
        } else if section == 7 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalPriceTableViewCell") as! TotalPriceTableViewCell
            cell.setValues(price: rentsalPriceArray)
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalPriceTableViewCell") as! TotalPriceTableViewCell
            cell.setValues(price: rentsalPriceArray)
            
            return cell
            
        }
        
    }
    
}

extension TbPropertyDetailsViewController: AllPhotoDelegate {
    func didTapMoreBtn() {
//        print("From tb did tap: \(photos)")
        
        performSegue(withIdentifier: "allPhotoSegue", sender: id)
    }
    //
    //    func didTapMoreBtn() {
    //
    //
    //    }
    
}
