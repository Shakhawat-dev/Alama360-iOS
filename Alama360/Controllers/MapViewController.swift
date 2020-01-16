//
//  MapViewController.swift
//  Alama360
//
//  Created by Alama360 on 21/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import LanguageManager_iOS
import Alamofire
import SwiftyJSON
import GoogleMaps

class MapViewController: UIViewController {
    
    var mapProperties: MapModel?
    var lan: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyDod0SP5Eh_eZmNNES7aTJt3eXs1mooFHY")
        // Do any additional setup after loading the view.
        loadMap()
    }
    
    func loadMap() {
        
        lan = LanguageManager.shared.currentLanguage.rawValue
        
        let mUrl = StaticUrls.BASE_URL_FINAL + "daily-rental/for-rent?page=1&" + lan! + "&viewType=mapview"
        print(mUrl)
        
        let camera = GMSCameraPosition.camera(withLatitude: 21.509930034221852679365838412195444107, longitude: 39.342472851276397705078125, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250), camera: camera)
        self.view = mapView
        
        Alamofire.request(mUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                print(resultArray as Any)
                
                // Initiatoing resultArray into specific array
                for i in resultArray.arrayValue {
                    
                    let latitude = i["latitude"].doubleValue
                    let longitude = i["longitude"].doubleValue

                    // Creates a marker in the center of the map.
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    //        marker.title = pTitle
                    //        marker.snippet = pCityname
                    marker.icon = #imageLiteral(resourceName: "marker_2")
                    marker.map = mapView
                    
                    mapView.selectedMarker = marker
                    //                    mapView.delegate = self as! GMSMapViewDelegate
                }
                
                self.showMap()
            }
            
        }
        
    }
    
    func showMap() {
        //        GMSServices.provideAPIKey("AIzaSyDod0SP5Eh_eZmNNES7aTJt3eXs1mooFHY")
        //
        //
        //
        //        let latitude = mapProperties?.latitude
        //        let longitude = mapProperties?.longitude
        //
        //
        //        let camera = GMSCameraPosition.camera(withLatitude: latitude!, longitude: longitude!, zoom: 10.0)
        //        let mapView = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250), camera: camera)
        //        view = mapView
        //
        //        // Creates a marker in the center of the map.
        //        let marker = GMSMarker()
        //        marker.position = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        ////        marker.title = pTitle
        ////        marker.snippet = pCityname
        //        marker.icon = #imageLiteral(resourceName: "marker_2")
        //        marker.map = mapView
        //
        //        mapView.selectedMarker = marker
        
    }
}
