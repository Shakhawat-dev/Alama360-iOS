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

class TbPropertyDetailsViewController: UIViewController {
    
    var lan: String = ""
    var userId: String = ""
    var id: String?
    var rCount: Int = 0
    
    var pTitle: String?
    var pCityname: String?
    var pDistName: String?
    var pShort_des: String?
    var pAddress: String?
    var pLatitude: Double?
    var pLongitude: Double?
    var tour: String?
    var pYoutube_video_url: String?
    var photos: PhotosModel?
    var property_dailyfeature: FeatureModel?
    var landmark_arr = [String]()
    //    var cellRowClass : [String: String] = ["" : ""]
    var cellRowClass = [String]()
    
    @IBOutlet weak var propertyDetailsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getPropertyDetails()
        rowCount ()
        
    }
    
    // Get Api Call
    func getPropertyDetails() {
        
        lan = LocalizationSystem.sharedInstance.getLanguage()
        
        let pdUrl = StaticUrls.BASE_URL_FINAL + "propertydetails/\(id!)?lang=\(lan)&userid=124"
        
        // URL check
        print("Response bUrl is: \(pdUrl)")
        
        Alamofire.request(pdUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                print(resultArray as Any)
                
                // Initiatoing resultArray into specific array
                
                
                self.pTitle = resultArray["title"].stringValue
                self.pCityname = resultArray["cityname"].stringValue
                self.pDistName = resultArray["dist_districtInfo"]["name"].stringValue
                self.pShort_des = resultArray["dist_districtInfo"]["description"].stringValue
                self.tour = resultArray["tour"].stringValue
                self.pYoutube_video_url = resultArray["youtube_video_url"].stringValue
                self.pLatitude = resultArray["latitude"].doubleValue
                self.pLongitude = resultArray["longitude"].doubleValue
                
                for i in resultArray["landmarks"].arrayValue {
                    let name = i["name"].stringValue
                    self.landmark_arr.append(name)
                }
                
                let photoArray = resultArray["photos"]["photosaall"].arrayValue
                let newPhoto = PhotosModel(json: JSON(photoArray))
                self.photos = newPhoto
                
                let featureArray = resultArray["property_dailyfeature"].arrayValue
                let newFeature = FeatureModel(json: JSON(featureArray))
                self.property_dailyfeature = newFeature
                
                print(self.property_dailyfeature)
                
                
                self.propertyDetailsTable.delegate = self
                self.propertyDetailsTable.dataSource = self
                self.propertyDetailsTable.reloadData()
                
                self.getMapView ()
                //                self.setValues()
                //                self.getYoutubeVideo()
                
                
                //                self.featuresTableView.layoutIfNeeded()
                //                self.featuresTableView.heightAnchor.constraint(equalToConstant: self.featuresTableView.contentSize.height).isActive = true
                
                // For setting row in tableview
//                if self.tour != "" {
//                    self.rCount += 1
//                    self.cellRowClass.append("Property360Cell")
//                }
//                if (self.photos?.picture[0])! != "" {
//                    self.rCount += 1
//                    self.cellRowClass.append("PhotoGridCell")
//                }
//                if self.pYoutube_video_url != "" {
//                    self.rCount += 1
//                    self.cellRowClass.append("YoutubeCell")
//                }
//                if self.title != "" {
//                    self.rCount += 1
//                    self.cellRowClass.append("NamePolicyCell")
//                }
//
//                print("Row Count is : \(self.rCount)")
                
            }
            
        }
        
    }
    
    func getMapView () {
        
        GMSServices.provideAPIKey("AIzaSyDod0SP5Eh_eZmNNES7aTJt3eXs1mooFHY")
        
        let camera = GMSCameraPosition.camera(withLatitude: pLatitude!, longitude: pLongitude!, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250), camera: camera)
        propertyDetailsTable.tableFooterView = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: pLatitude!, longitude: pLongitude!)
        marker.title = pTitle
        marker.snippet = pCityname
        marker.icon = #imageLiteral(resourceName: "marker_2")
        marker.map = mapView
        
        mapView.selectedMarker = marker
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
        if segue.identifier == "allPhotoSegue" {
            let destVC = segue.destination as! AllPhotosViewController
            destVC.id = sender as? String
        }
    }
    
    // Count for row
    func rowCount () {}
    
    
    
}

extension TbPropertyDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        //        if pShort_des == "" && property_dailyfeature?.col1_array == nil && landmark_arr[0] == "" {
        //            return 1
        //        } else if pShort_des == "" && property_dailyfeature?.col1_array == nil {
        //            return 2
        //        } else if pShort_des == "" && landmark_arr[0] == "" {
        //            return 2
        //        } else if landmark_arr[0] == "" && property_dailyfeature?.col1_array == nil {
        //            return 2
        //        } else if pShort_des == "" || property_dailyfeature?.col1_array == nil || landmark_arr[0] == ""  {
        //            return 3
        //        } else {
        //            return 4
        //        }
        return 4
        
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
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row: Int = 4
        if section == 0 {
            
            //            if tour != "" && pYoutube_video_url != "" && photos?.picture[0] != "" {
            //                row = 4
            //            } else if pYoutube_video_url != "" && tour != "" {
            //                row = 3
            //            } else if tour != "" && photos?.picture[0] != "" {
            //                row = 3
            //            } else if photos?.picture[0] != "" && pYoutube_video_url != "" {
            //                row = 3
            //            }
            
            
            return 4
        } else if section == 2{
            return (property_dailyfeature?.col1_array.count)!
        } else if section == 3 {
            return landmark_arr.count
        } else {
            return 1
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight:CGFloat = 0.0
        //        let frame = tableView.rectForRow(at: indexPath)
        if indexPath.row == 0 {
            if tour == "" {
                rowHeight = 0.0
            } else {
                rowHeight = tableView.rowHeight
            }
            return rowHeight
            
        } else if indexPath.row == 1 {
            
            if photos?.picture[0] == "" {
                rowHeight = 0.0
            } else {
                rowHeight = tableView.rowHeight
            }
            return rowHeight
            
        } else if indexPath.row == 2 {
            
            if pYoutube_video_url == "" {
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
        
        if section == 0 {
            
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Property360Cell") as! Property360Cell
                if tour != "" {
                    cell.get360View(url: tour!)
                    print("360 view url: \(tour)")
                }
                
                
                return cell
            } else if row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoGridCell") as! PhotoGridCell
                
                if photos?.picture[0] == "" {
                    
                    cell.isHidden = true
                    
                    return cell
                } else {
                    cell.setValues(aPhotos: photos!)
                    cell.delegate = self
                    
                    return cell }
            } else if row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "YoutubeCell") as! YoutubeCell
                
                cell.getYoutubeView(yUrl: pYoutube_video_url!)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NamePolicyCell") as! NamePolicyCell
                
                cell.propertyName.text = pTitle
                cell.cityName.text = pCityname
                cell.districtName.text = pDistName
                
                return cell
            }
            
            //            var rcell: UITableViewCell?
            //
            //            for i in 0...rCount {
            //                if row == i {
            //                    if cellRowClass[i] == "Property360Cell" {
            //                        let cell = tableView.dequeueReusableCell(withIdentifier: "Property360Cell") as! Property360Cell
            //
            //                        rcell = cell
            //                    }
            //                    else if cellRowClass[i] == "PhotoGridCell" {
            //                        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoGridCell") as! PhotoGridCell
            //
            //                            cell.setValues(aPhotos: photos!)
            //                            cell.delegate = self
            //
            //                        rcell = cell
            //                    }
            //                    else if cellRowClass[i] == "YoutubeCell" {
            //                        let cell = tableView.dequeueReusableCell(withIdentifier: "YoutubeCell") as! YoutubeCell
            //
            //                        cell.getYoutubeView(yUrl: pYoutube_video_url!)
            //
            //                        rcell = cell
            //                    }
            //                    else  {
            ////                        if cellRowClass[i] == "NamePolicyCell"
            //                        let cell = tableView.dequeueReusableCell(withIdentifier: "NamePolicyCell") as! NamePolicyCell
            //
            //                        cell.propertyName.text = pTitle
            //                         cell.cityName.text = pCityname
            //                         cell.districtName.text = pDistName
            //
            //                        rcell = cell
            //                    }
            //                    return rcell!
            //                }
            //
            //
            //            }
            //
            //            return rcell!
            
            
        } else if section == 1 && pShort_des != "" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PdDescriptionCell") as! PdDescriptionCell
            
            cell.pDescription.text = pShort_des
            
            return cell
        }  else if section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureCell") as! FeatureCell
            
            cell.featureName.text = property_dailyfeature?.col1_array[indexPath.row]
            cell.featureImage.image = getImage(from: substringIcon(text: (property_dailyfeature?.icon_array[indexPath.row])!))
            
            return cell
        } else if section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LandmarkCell") as! LandmarkCell
            
            cell.landmarkName.text = landmark_arr[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyMapCell") as! PropertyMapCell
            
            cell.isHidden = true
            
            return cell
        }
        
    }
    
}

extension TbPropertyDetailsViewController: AllPhotoDelegate {
    func didTapMoreBtn() {
        print("From tb did tap: \(photos)")
        
        performSegue(withIdentifier: "allPhotoSegue", sender: id)
    }
    //
    //    func didTapMoreBtn() {
    //
    //
    //    }
    
}
