//
//  BookingViewController.swift
//  Alama360
//
//  Created by Alama360 on 21/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ImageSlideshow
import AlamofireImage

class BookingViewController: UIViewController {
    
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var mapSortContainerView: UIView!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var propertySlideShow: ImageSlideshow!
    
    var searchController: UISearchController!
    var originalDataSource: [String] = []
    var currentDataSource: [String] = []
    
    // Param Variables
    var startDate = ""
    var lan = ""
    var thumcate = ""
    var address = ""
    
    // Response Arrays
    private var arr_thumbnail = [UIImage]()
    private var arr_id = [String]()
    private var arr_property_type = [String]()
    private var arr_latitude = [String]()
    private var arr_longitude = [String]()
    private var arr_search_keywords = [String]()
    private var arr_updated_at = [String]()
    private var arr_no_roomcaption = [String]()
    private var arr_no_bathroomcaption = [String]()
    private var arr_evalnumber = [String]()
    private var arr_favorite_info = [String]()
    
    // Property Daily feature
    private var arr_pd_id = [String]()
    private var arr_pd_col1 = [String]()
    private var arr_pd_icone = [String]()
    
    private var arr_tour = [String]()
    private var arr_dayprice = [String]()
    private var arr_title = [String]()
    private var arr_short_des = [String]()
    private var arr_address = [String]()
    private var arr_cityname = [String]()
    private var arr_districtname = [String]()
    
    private var arr_picture = [String]()
    private var arr_picture_child = [String]()
    
    private var id_picture = [String: String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ADDING array data to table view
//        addProductToDataSource(productCount: 25, product: "Chalets")
//        addProductToDataSource(productCount: 20, product: "Hotels")
//        addProductToDataSource(productCount: 20, product: "something")
        //
        
        
//        tableView.delegate = self
//        tableView.dataSource = self
        //
        currentDataSource = originalDataSource
        //
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        // For search view focus
        searchController.obscuresBackgroundDuringPresentation = false
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        
        
        // Do any additional setup after loading the view.
        getPropertiesForDate()
        
    }
    
    // Load Booking List
    func getPropertiesForDate() {
        
        lan = LocalizationSystem.sharedInstance.getLanguage()
        
        let params : [String : String] = ["start" : "2019-12-19", "viewType" : "mapview", "lang" : lan, "thumbcat" : thumcate, "address" : address]
        
        let bUrl = "https://alama360.com/api/android/propertylist?"
        
        // URL check
        print("Response bUrl is: \(bUrl)" + "\(params)")
        
        Alamofire.request(bUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
//                let photoArray = resutArray["photos"]
                
                print(resultArray as Any)
                
//                print(photoArray as Any)
                
                self.arr_thumbnail.removeAll()
                self.arr_id.removeAll()
                self.arr_property_type.removeAll()
                self.arr_latitude.removeAll()
                self.arr_longitude.removeAll()
                self.arr_search_keywords.removeAll()
                self.arr_updated_at.removeAll()
                self.arr_no_roomcaption.removeAll()
                self.arr_no_bathroomcaption.removeAll()
                self.arr_evalnumber.removeAll()
                self.arr_picture.removeAll()
                self.arr_favorite_info.removeAll()
                self.arr_pd_id.removeAll()
                self.arr_pd_col1.removeAll()
                self.arr_pd_icone.removeAll()
                self.arr_tour.removeAll()
                self.arr_dayprice.removeAll()
                self.arr_title.removeAll()
                self.arr_short_des.removeAll()
                self.arr_address.removeAll()
                self.arr_cityname.removeAll()
                self.arr_districtname.removeAll()
                self.arr_picture_child.removeAll()
                
                // Initiatoing resultArray into specific array
                for i in resultArray.arrayValue {
                    
                    let id = i["id"].stringValue
                    self.arr_id.append(id)
                    
                    let property_type = i["property_type"].stringValue
                    self.arr_property_type.append(property_type)
                    
                    let latitude = i["latitude"].stringValue
                    self.arr_latitude.append(latitude)
                    
                    let longitude = i["longitude"].stringValue
                    self.arr_longitude.append(longitude)
                    
                    let search_keywords = i["search_keywords"].stringValue
                    self.arr_search_keywords.append(search_keywords)
                    
                    let updated_at = i["updated_at"].stringValue
                    self.arr_updated_at.append(updated_at)
                    
                    let no_roomcaption = i["no_roomcaption"].stringValue
                    self.arr_no_roomcaption.append(no_roomcaption)
                    
                    let no_bathroomcaption = i["no_bathroomcaption"].stringValue
                    self.arr_no_bathroomcaption.append(no_bathroomcaption)
                    
                    let evalnumber = i["evalnumber"].stringValue
                    self.arr_evalnumber.append(evalnumber)
                    
                    let favorite_info = i["favorite_info"].stringValue
                    self.arr_favorite_info.append(favorite_info)
                    
                    let tour = i["tour"].stringValue
                    self.arr_tour.append(tour)
                    
                    let dayprice = i["dayprice"].stringValue
                    self.arr_dayprice.append(dayprice)
                    
                    let title = i["title"].stringValue
                    self.arr_title.append(title)
                    
                    let short_des = i["short_des"].stringValue
                    self.arr_short_des.append(short_des)
                    
                    let address = i["address"].stringValue
                    self.arr_address.append(address)
                    
                    let cityname = i["cityname"].stringValue
                    self.arr_cityname.append(cityname)
                    
                    let districtname = i["districtname"].stringValue
                    self.arr_districtname.append(districtname)
                    
                    self.arr_picture_child.removeAll()

                    
                    for j in  i["photos"].arrayValue {
                        // Object, array index, object
                        let photos: String! = j["picture"].string
                        
                        self.arr_picture_child.append(photos)
                        self.id_picture[photos] = id
                        
                    }
                    
                    let newarr = i["property_dailyfeature"].arrayValue
                    
                    print(newarr)
                    for j in  newarr {
                        // Object, array index, object
                        let id: String? = j["id"].string
                        self.arr_pd_id.append(id ?? "")

                        let col1: String? = j["col1"].string
                        self.arr_pd_col1.append(col1 ?? "")

                        let icon: String? = j["icon"].string
                        self.arr_pd_icone.append(icon ?? "")

                    }
                    
//                    self.addProductToDataSource(title: title, id: id, images: self.arr_picture_child)
                   

                    
//                    let photos: String! = i["photos"][1]["picture"].string
//                    print(photos as Any)
                    
//                    self.arr_picture.append(photos)
                    
//                    self.tableView.reloadData()
//
//                    self.tableView.delegate = self
//                    self.tableView.dataSource = self
                    
                }
//                print("\n picutures are: \(self.arr_picture_child)")
//
                self.tableView.delegate = self
                self.tableView.dataSource = self
                
                self.tableView.reloadData()
//
//                print("user id: \(self.arr_districtname)")
//                print("Total id: \(self.arr_districtname.count)")
//                print("Pictures: \(self.arr_picture)")
//                print("Total Pictures: \(self.arr_picture.count)")
//
                for (picture, id) in self.id_picture {
                    print("ID \(id) and Picture is \(picture)")
                }
//
                
//                self.addProductToDataSource(productCount: 25, product: "Chalets")
//                self.addProductToDataSource(productCount: 20, product: "Hotels")
//                self.addProductToDataSource(productCount: 20, product: "something")
                
            }
            
        }
        
    }
    
    // Image slideshow for row
    func imageSlideShow() {

                propertySlideShow.setImageInputs([
                    ImageSource(image: UIImage(named: "alama_logo")!),
                    ImageSource(image: UIImage(named: "alama_logo")!),
    //          AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080"),
              
            ])
            
        }
    
    // Recieving and Showing data
    func addProductToDataSource(title: String, id: String, images: [String]) {
        
//        for index in 1...productCount {
//
//            originalDataSource.append("\(product) #\(index)")
//
//        }
//        arr_title.removeAll()
//        arr_id.removeAll()
//        arr_picture_child.removeAll()
        
        
        arr_title.append(title)
        arr_id.append(id)
        arr_picture_child = images
        
        print("\(arr_title)  / \(arr_id) /  \(arr_picture_child)")
        
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        self.tableView.reloadData()
        
    }
    
    // Search Filtering
    func filteringCurrentDataSource (searchTerm: String) {
        
        if searchTerm.count > 0 {
            
            currentDataSource = originalDataSource
            
            let filteredResult = currentDataSource.filter {
                $0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())
            }
            
            currentDataSource = filteredResult
            tableView.reloadData()
            
        }
        
    }
    
    func restoreCurrentDataSource() {
        currentDataSource = originalDataSource
        tableView.reloadData()
    }
    
    @IBAction func mapBtnClicked(_ sender: UIButton) {
        
    }
    @IBAction func sortBtnClicked(_ sender: UIButton) {
        
    }
    
    
}

extension BookingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            filteringCurrentDataSource(searchTerm: searchText)
        }
        
    }
    
}

extension BookingViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.isActive = false
        
        if let searchText = searchBar.text {
            filteringCurrentDataSource(searchTerm: searchText)
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.isActive = false
        restoreCurrentDataSource()
        if let searchText = searchBar.text, !searchText.isEmpty {
            restoreCurrentDataSource()
        }
    }
    
}

extension BookingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "Selection", message: "Selected: \(currentDataSource[indexPath.row])", preferredStyle: .alert)
        
        searchController.isActive = false
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
    }
    func escape(string: String) -> String {
        let allowedCharacters = string.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: ":=\"#%/<>?@\\^`{|}").inverted) ?? ""
        return allowedCharacters
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Use Always current DataSource
        return arr_title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookingTableViewCell
        
        for(photo, id) in id_picture {
            
            if id == arr_id[indexPath.row] {
                if(id != "156"){
                   // let strurl="https://alama360.com/lara/public/properties/" + id + "/photos/small/" + photo
                    //let url = encodeUrl(from:strurl)
//                    let strEncoded = self.escape(string: "https://alama360.com/lara/public/properties/" + id + "/photos/small/" + photo)
                    cell.propertyRowSlideShow.setImageInputs([(AlamofireSource(urlString: "https://alama360.com/lara/public/properties/" + id + "/photos/small/" + photo)!)])
//                    cell.propertyRowSlideShow.setImageInputs([])

               print("https://alama360.com/lara/public/properties/" + "\(id )" + "/photos/small/" + "\(photo)")
                }
            }
            
            // [AlamofireSource(urlString: "https://alama360.com/lara/public/properties/" + id + "/photos/small/" + photo)!]
        }
        
//        for i in 0...4 {
//
//        }
        
        
        
        
//        cell.propertyRowSlideShow.setImageInputs([
//                        ImageSource(image: UIImage(named: "alama_logo")!),
//                        ImageSource(image: UIImage(named: "alama_logo")!),
//        //          AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080"),
//
//                ])
    
        cell.rowTitle.text = arr_title[indexPath.row]
        
        if arr_districtname[indexPath.row] != "" {
            cell.rowCityName.text = arr_cityname[indexPath.row] + ", " + arr_districtname[indexPath.row]
        } else {
            cell.rowCityName.text = arr_cityname[indexPath.row]
        }
        
        if arr_dayprice[indexPath.row] != "" {
            cell.rowDayPrice.text = arr_dayprice[indexPath.row]
        }
         
        return cell
    }
    
}
