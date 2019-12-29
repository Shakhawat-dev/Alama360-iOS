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
    
    
    private var f_col = [String]()
    
    var property_list = [BookingModel]()
    var arrrFeatures = [FeatureModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDataSource = originalDataSource
        //
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        // For search view focus
        searchController.obscuresBackgroundDuringPresentation = false
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        
        getPropertiesForDate()
        
    }
    
    // Load Booking List
    func getPropertiesForDate() {
        
        lan = LocalizationSystem.sharedInstance.getLanguage()
        
        let params : [String : String] = ["start" : "2019-12-19", "viewType" : "mapview", "lang" : lan, "thumbcat" : thumcate, "address" : address]
        
        let bUrl = StaticUrls.BASE_URL_FINAL + "android/propertylist?"
        
        // URL check
        print("Response bUrl is: \(bUrl)" + "\(params)")
        
        Alamofire.request(bUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                print(resultArray as Any)
                
                // Initiatoing resultArray into specific array
                for i in resultArray.arrayValue {
                    
                    let newProperty = BookingModel(json: i)
                    
                    self.property_list.append(newProperty)
                    
                    self.tableView.reloadData()
                    
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    
                    // print(self.property_list)
                    
                }
                
            }
            
        }
        
    }
    
    // Recieving and Showing data
    func addProductToDataSource(title: String, id: String, images: [String], features: [String]) {
        
        //        arr_title.append(title)
        //        arr_id.append(id)
        //        arr_picture_child = images
        //        f_col = features
        
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
        
        // let alertController = UIAlertController(title: "Selection", message: "Selected: \(currentDataSource[indexPath.row])", preferredStyle: .alert)
        
        // searchController.isActive = false
        
        // let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        // alertController.addAction(okAction)
        // present(alertController, animated: true, completion: nil)
        
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
        
        if property_list[indexPath.row].dayprice != "" {
            cell.rowDayPrice.text = property_list[indexPath.row].dayprice!
        } else {
            cell.rowDayPrice.text = ""
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
            }
            
        }
        
        if let icons_array: [String] = property_list[indexPath.row].property_dailyfeature?.icon_array {
            
            // print("individual : \(icons_array)")
            
            if icons_array.count == 3 {
                
                let icon1  = substringIcon(text: icons_array[0])
                let icon2  = substringIcon(text: icons_array[1])
                let icon3  = substringIcon(text: icons_array[2])
                
                cell.featureImageOne.image = getImage(from: icon1)
                cell.featureImageTwo.image = getImage(from: icon2)
                cell.featureImageThree.image = getImage(from: icon3)
                
            }
            
        }
        
        return cell
    }
    
}


