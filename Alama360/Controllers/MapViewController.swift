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

class MapViewController: UIViewController, GMSMapViewDelegate {
    
//    @IBOutlet weak var mapView: GMSMapView!
    
    //For storing user data
    let defaults = UserDefaults.standard
    var startDate = ""
    var endDate = ""
    var mapProperties: MapModel?
    var lan: String?
    
    var tappedMarker : GMSMarker?
    var propertryInfoWindow : PropertyInfoWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        startDate = defaults.string(forKey: "startDate") ?? ""
        startDate = defaults.string(forKey: "endDate") ?? ""
        
        GMSServices.provideAPIKey("AIzaSyDod0SP5Eh_eZmNNES7aTJt3eXs1mooFHY")
        // Do any additional setup after loading the view.
        loadMap()
    }
    
    func loadMap() {
        
        lan = LanguageManager.shared.currentLanguage.rawValue
        
//        https://alama360.com/api/android/propertylist?lang=en&startDate=2020-02-08&endDate=2020-02-11
        
        let mUrl = StaticUrls.BASE_URL_FINAL + "android/propertylist?lang=" + lan! + "&startDate=" + startDate + "&endDate=" + endDate + "&limit=100&page=1"
        print(mUrl)
        
        let camera = GMSCameraPosition.camera(withLatitude: 21.509930034221852679365838412195444107, longitude: 39.342472851276397705078125, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero , camera: camera)
        
        mapView.settings.compassButton = true
        
        self.view = mapView
        
        Alamofire.request(mUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
//                print(resultArray as Any)
                
                // Initiatoing resultArray into specific array
                for i in resultArray.arrayValue {
                    
                    let latitude = i["latitude"].doubleValue
                    let longitude = i["longitude"].doubleValue
                    let title = i["title"].stringValue
                    
//                    print("\(title) \(latitude)")
                    // Creates a marker in the center of the map.
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    marker.title = title
                    //        marker.snippet = pCityname
                    marker.icon = #imageLiteral(resourceName: "marker_2")
                    marker.map = mapView
                    
                    mapView.selectedMarker = marker
                    mapView.camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 10)
                    
                    self.tappedMarker = GMSMarker()
                    self.propertryInfoWindow = PropertyInfoWindow().loadView()
                    //                    self.mapView.delegate = self
                }
                
            }
            
        }
        
    }
    
}
