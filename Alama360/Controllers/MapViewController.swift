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
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var mapProperties: MapModel?
    var lan: String?
    var tappedMarker : GMSMarker?
    var propertryInfoWindow : PropertyInfoWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light //For light mode
        
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
                    let title = i["title"].stringValue

                    // Creates a marker in the center of the map.
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                            marker.title = title
                    //        marker.snippet = pCityname
                    marker.icon = #imageLiteral(resourceName: "marker_2")
                    marker.map = mapView
                    
                    mapView.selectedMarker = marker
                    
                    self.tappedMarker = GMSMarker()
                    self.propertryInfoWindow = PropertyInfoWindow().loadView()
//                    self.mapView.delegate = self
                }
                
            }
            
        }
        
    }
    
}
