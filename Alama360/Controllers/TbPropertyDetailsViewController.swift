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

    var pTitle: String?
    var pCityname: String?
    var pDistName: String?
    var pShort_des: String?
    var pAddress: String?
    var pLatitude: Double?
    var pLongitude: Double?
    var pYoutube_video_url: String? = ""
    var photos: PhotosModel?
    var property_dailyfeature: FeatureModel?
    var landmark_arr = [String]()

    @IBOutlet weak var propertyDetailsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getPropertyDetails()
        
    }
    
    // Get Api Call
    func getPropertyDetails() {
        
        lan = LocalizationSystem.sharedInstance.getLanguage()
        
        let pdUrl = StaticUrls.BASE_URL_FINAL + "propertydetails/130?lang=en&userid=124"
        
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
            destVC.allPhotos = sender as? PhotosModel
        }
    }


}

extension TbPropertyDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: propertyDetailsTable.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: propertyDetailsTable.frame.size.width, height: 18))
        label.font = UIFont.systemFont(ofSize: 14)
        
        if section == 0 {
            label.text = "Property"
            view.addSubview(label)
            view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) // Set your background color
            
            return view
        } else if section == 1 {
            label.text = "Description"
            view.addSubview(label)
            view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) // Set your background color
            
            return view
        }  else if section == 2 {
            label.text = "Features"
            view.addSubview(label)
            view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) // Set your background color
            
            return view
        } else if section == 3 {
            label.text = "Landmarks"
            view.addSubview(label)
            view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) // Set your background color
            
            return view
        } else if section == 4 {
            label.text = "Maps"
            view.addSubview(label)
            view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) // Set your background color
            
            return view
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 4
        } else if section == 2{
            return (property_dailyfeature?.col1_array.count)!
        } else if section == 3 {
            return landmark_arr.count
        } else {
            return 1
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let section = indexPath.section
        
        if section == 0 {
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Property360Cell") as! Property360Cell
                
                return cell
            } else if row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoGridCell") as! PhotoGridCell
                
                
//                cell.allPhotos = photos
                
                cell.setValues(aPhotos: photos!)
                cell.delegate = self
                
//                cell.thumbOne.image = getImage(from: (photos?.picture[0])!)
//                cell.thumbTwo.image = getImage(from: (photos?.picture[1])!)
//                cell.thumbThree.image = getImage(from: (photos?.picture[2])!)
//                cell.thumbFour.image = getImage(from: (photos?.picture[3])!)
//                cell.thumbFive.image = getImage(from: (photos?.picture[4])!)
                
                
                return cell
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
              
        } else if section == 1 {
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
    func didTapMoreBtn(pPhotos: PhotosModel) {
        performSegue(withIdentifier: "allPhotoSegue", sender: pPhotos)
    }
    
}
