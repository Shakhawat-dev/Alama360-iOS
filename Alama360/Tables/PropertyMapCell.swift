//
//  PropertyMapCell.swift
//  Alama360
//
//  Created by Alama360 on 12/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import GoogleMaps

class PropertyMapCell: UITableViewCell {

    var latitude: String = ""
    var longitude: String = ""
    
//    @IBOutlet weak var propertyMapView: UIView!
    @IBOutlet weak var propertyMap: GMSMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        propertyMap.layer.cornerRadius = 8
        propertyMap.layer.shadowOffset = CGSize(width: 0.4, height: 0.4)
        propertyMap.layer.shadowRadius = 8
        propertyMap.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
//        GMSServices.provideAPIKey("AIzaSyDod0SP5Eh_eZmNNES7aTJt3eXs1mooFHY")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getMapValues (lat: Double, longi: Double, title: String, cityName: String) {
        
//        GMSServices.provideAPIKey("AIzaSyDv0ELUI8m5cOL1jLGlkc2TOj1-8PZMPzk")
//
//        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: longi, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        propertyMapView = mapView
//
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: longi)
//        marker.title = title
//        marker.snippet = cityName
//        marker.map = propertyMapView as! GMSMapView
        
//        GMSServices.provideAPIKey("AIzaSyDod0SP5Eh_eZmNNES7aTJt3eXs1mooFHY")
        
//        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: longi, zoom: 10.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250), camera: camera)
//
//        // Using map as footerview
////        propertyMap = mapView
//
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: longi)
//        marker.title = title
//        marker.snippet = cityName
//        marker.icon = #imageLiteral(resourceName: "marker_2")
//        marker.map = mapView
//
//        mapView.selectedMarker = marker
//
//        propertyMap = mapView
        
        let marker = GMSMarker()
        
//                let lat = Double("13.063754")
//                let long = Double("80.24358699999993")
        marker.position = CLLocationCoordinate2DMake(lat,longi)
        
        ///View for Marker
        let DynamicView = UIView(frame: CGRect(x:0, y:0, width:50, height:50))
        DynamicView.backgroundColor = UIColor.clear
        
        //Pin image view for Custom Marker
//        let imageView = UIImageView()
//        imageView.frame  = CGRect(x:0, y:0, width:50, height:35)
//        imageView.image = #imageLiteral(resourceName: "marker_2")
        
        //Adding pin image to view for Custom Marker
//        DynamicView.addSubview(imageView)
//
//        UIGraphicsBeginImageContextWithOptions(DynamicView.frame.size, false, UIScreen.main.scale)
//        DynamicView.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let imageConverted: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
        
        marker.icon = #imageLiteral(resourceName: "marker_2")
        marker.map = propertyMap
        marker.title = title
        marker.snippet = cityName
        propertyMap.selectedMarker = marker
        propertyMap.camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: 11)
    }
    
    

}
