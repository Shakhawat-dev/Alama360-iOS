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
import DropDown
import SVProgressHUD

class BookingViewController: UIViewController {
    
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var mapSortContainerView: UIView!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var propertySlideShow: ImageSlideshow!
    let sortDropDown = DropDown()
    
    //For storing user data
    let defaults = UserDefaults.standard
    
    var dataTasks : [URLSessionDataTask] = []
    
    var searchController: UISearchController!
    var originalDataSource = [BookingModel]()
    var currentDataSource = [BookingModel]()
    
    var propParam : (title: String, cate: String, thumbcate: String, startDate: String, endDate: String)?
    // Param Variables
    var startDate = ""
    var endDate = ""
    var lan = ""
    var thumbcate = ""
    var address = ""
    var pType = ""
    var id = ""
    var currentPage: Int = 1
    
    private var f_col = [String]()
    var property_list = [BookingModel]()
    var arrrFeatures = [FeatureModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light //For light mode
        
        // For Hiding keyboard on Tap
        self.hideKeyboardWhenTappedAround()
        
        //        currentDataSource = originalDataSource
        startDate = propParam?.startDate ?? ""
        endDate = propParam?.endDate ?? "" // May come nil if not selected...
        thumbcate = propParam?.thumbcate ?? ""
        address = propParam?.title ?? ""
        pType = propParam?.cate ?? ""
        
        // Setting Dates as defaults
        defaults.set(startDate, forKey: "startDate")
        defaults.set(endDate, forKey: "endDate")
        
//        searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
//        // For search view focus
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchContainerView.addSubview(searchController.searchBar)
//        searchController.searchBar.delegate = self
        
        //        getPropertiesForDate()
        //        fetchProperties(ofIndex: currentPage)
        
        getPropertiesForDate(page: currentPage)
        
        setLocalization()
        loadSortDropDown()
        
        print("Booking Vc Params: \(propParam)")
        
    }
    
    func setLocalization() {
        mapBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "map", comment: "").localiz(), for: .normal)
        sortBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sort", comment: "").localiz(), for: .normal)
    }
    
    // Load Booking List
    func getPropertiesForDate(page: Int) {
        SVProgressHUD.show()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        lan = LocalizationSystem.sharedInstance.getLanguage()
        
        let params : [String : String] = ["page" : "\(page)", "lang" : lan, "viewType" : "", "startdate" : startDate, "enddate" : endDate, "property_type" : pType, "thumbcat" : thumbcate, "address" : address, "limit" : "10"]
        
        let bUrl = StaticUrls.BASE_URL_FINAL + "android/propertylist?"
        
        // URL check
        //print("Response bUrl is: \(bUrl)" + "\(params)")
        
        Alamofire.request(bUrl, method: .post, parameters: params, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
//                print(mysresponse.data as Any)
                
                // Initiatoing resultArray into specific array
                for i in resultArray.arrayValue {
                    
                    //                    let newProperty = BookingModel(json: i)
                    //
                    //                    self.property_list.append(newProperty)
                    self.property_list.append(BookingModel(json: i))
                    
                    self.currentDataSource = self.property_list
                    
                    // print(self.property_list)
                    
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                    
                }
                
            }
            
        }
        
    }
    
    //    func fetchProperties(ofIndex index: Int) {
    //        //      let newsID = newsIDs[index]
    //
    //        SVProgressHUD.show()
    //
    //
    //
    //        lan = LocalizationSystem.sharedInstance.getLanguage()
    //
    //        let bUrl = StaticUrls.BASE_URL_FINAL + "android/propertylist?"
    //        let url = URL(string: "\(bUrl)android/propertylist?page=\(index+1)&lang=\(lan)&startdate=\(startDate)&enddate=\(endDate)&property_type=\(pType)&thumbcat=\(thumbcate)&address=\(address)")!
    //
    //        // if there is already an existing data task for that specific news url, it means we already loaded it previously / currently loading it
    //        // stop re-downloading it by returning this function
    //        if dataTasks.firstIndex(where: { task in
    //            task.originalRequest?.url == url
    //        }) != nil {
    //            return
    //        }
    //
    //        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
    //            guard let data = data else {
    //                print("No data")
    //                return
    //            }
    //
    //            guard let myResult = try? JSON(data: data) else {
    //                print("Error: Couldn't decode data into property json")
    //                return
    //            }
    //            let resultArray = myResult["data"]
    //            print("fetch new method is \(myResult)")
    //
    //            // Initiatoing resultArray into specific array
    //            for i in resultArray.arrayValue {
    //
    //                //                    let newProperty = BookingModel(json: i)
    //                //
    //                //                    self.property_list.append(newProperty)
    //                self.property_list.append(BookingModel(json: i))
    //
    //                self.currentDataSource = self.property_list
    //
    //
    //
    //                // print(self.property_list)
    //                SVProgressHUD.dismiss()
    //            }
    //            // Parse JSON into array of Car struct using JSONDecoder
    //            //        guard let news = try? JSONDecoder().decode(News.self, from: data) else {
    //            //          print("Error: Couldn't decode data into news")
    //            //          return
    //            //        }
    //
    //            // replace the initial 'nil' value with the loaded news
    //            // to indicate that the news have been loaded for the table view
    //            //        self.newsArray[index] = news
    //
    //            // Update UI on main thread
    //            DispatchQueue.main.async {
    //                self.tableView.delegate = self
    //                self.tableView.dataSource = self
    //                self.tableView.prefetchDataSource = self
    //                let indexPath = IndexPath(row: index, section: 0)
    //                // check if the row of news which we are calling API to retrieve is in the visible rows area in screen
    //                // the 'indexPathsForVisibleRows?' is because indexPathsForVisibleRows might return nil when there is no rows in visible area/screen
    //                // if the indexPathsForVisibleRows is nil, '?? false' will make it become false
    //                if self.tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
    //                    // if the row is visible (means it is currently empty on screen, refresh it with the loaded data with fade animation
    //                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    //                }
    //            }
    //        }
    //
    //      // run the task of fetching news, and append it to the dataTasks array
    //      dataTask.resume()
    //      dataTasks.append(dataTask)
    //    }
    //
    //    // the 'index' parameter indicates the row index of tableview
    //    func cancelFetchProperties(ofIndex index: Int) {
    ////      let newsID = newsIDs[index]
    //      let bUrl = StaticUrls.BASE_URL_FINAL + "android/propertylist?"
    //      let url = URL(string: "\(bUrl)android/propertylist?page=\(index+1)&lang=\(lan)&startdate=\(startDate)&enddate=\(endDate)&property_type=\(pType)&thumbcat=\(thumbcate)&address=\(address)")!
    //
    //      // get the index of the dataTask which load this specific news
    //      // if there is no existing data task for the specific news, no need to cancel it
    //      guard let dataTaskIndex = dataTasks.index(where: { task in
    //        task.originalRequest?.url == url
    //      }) else {
    //        return
    //      }
    //
    //      let dataTask =  dataTasks[dataTaskIndex]
    //
    //      // cancel and remove the dataTask from the dataTasks array
    //      // so that a new datatask will be created and used to load news next time
    //      // since we already cancelled it before it has finished loading
    //      dataTask.cancel()
    //      dataTasks.remove(at: dataTaskIndex)
    //    }
    
    
    // Recieving and Showing data
    func addProductToDataSource() {
        
        
        
    }
    
    // Search Filtering
    func filteringCurrentDataSource (searchTerm: String) {
        
        if searchTerm.count > 0 {
            
            currentDataSource = property_list
            
            //            let filteredResult = currentDataSource.filter {
            //                $0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())
            //            }
            //            let filteredResult = currentDataSource.filter({$0.title?.prefix(searchTerm.count)})
            
            //            currentDataSource = filteredResult
            tableView.reloadData()
            
        }
        
    }
    
    func restoreCurrentDataSource() {
        currentDataSource = originalDataSource
        tableView.reloadData()
    }
    
    @IBAction func mapBtnClicked(_ sender: UIButton) {
        
    }
    
    func loadSortDropDown() {
        sortDropDown.anchorView = mapSortContainerView
        sortDropDown.direction = .bottom
        sortDropDown.dataSource = [LocalizationSystem.sharedInstance.localizedStringForKey(key: "sort_high", comment: "").localiz(), LocalizationSystem.sharedInstance.localizedStringForKey(key: "sort_low", comment: "").localiz()]
        sortDropDown.cellConfiguration = { (index, item) in return "\(item)" }
        
    }
    
    @IBAction func sortBtnClicked(_ sender: UIButton) {
        
        sortDropDown.selectionAction = {
            (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            if index == 0 {
                self.property_list.sort { $0.dayprice! > $1.dayprice! }
                self.tableView.reloadData()
            } else {
                self.property_list.sort { $0.dayprice! < $1.dayprice! }
                self.tableView.reloadData()
            }
            
        }
        
        sortDropDown.width = view.bounds.width
        
        sortDropDown.bottomOffset = CGPoint(x: 0, y:(sortDropDown.anchorView?.plainView.bounds.height)!)
        
        sortDropDown.show()
        
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
        if segue.identifier == "showDetails" {
            let destVC = segue.destination as! TbPropertyDetailsViewController
            destVC.id = sender as? String
        }
    }
    
    
}

extension BookingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            filteringCurrentDataSource(searchTerm: searchText)
        }
        
    }
    
}

//extension BookingViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        searchController.isActive = false
//
//        if let searchText = searchBar.text {
//            filteringCurrentDataSource(searchTerm: searchText)
//        }
//
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//
//        searchController.isActive = false
//        restoreCurrentDataSource()
//        if let searchText = searchBar.text, !searchText.isEmpty {
//            restoreCurrentDataSource()
//        }
//    }
//
//}

extension BookingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // let alertController = UIAlertController(title: "Selection", message: "Selected: \(currentDataSource[indexPath.row])", preferredStyle: .alert)
        
        // searchController.isActive = false
        
        // let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        // alertController.addAction(okAction)
        // present(alertController, animated: true, completion: nil)
        
        id = property_list[indexPath.row].id!
        performSegue(withIdentifier: "showDetails", sender: id)
        
        //        let pdParams = (id : id, startDate: startDate, endDate: endDate )
        //        print("property Param is : \(pdParams)")
        //        performSegue(withIdentifier: "showDetails", sender: pdParams)
        
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
        
        //         self.fetchNews(ofIndex: indexPath.row)
        
//        if let props = property_list[indexPath.row].title {
        
        if indexPath.row + 1 == property_list.count {
            currentPage += 1
            getPropertiesForDate(page: currentPage)
        }
            
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
                
                if property_list[indexPath.row].totalday! > 1 {
                    cell.totalDaysLbl.text = String(describing: property_list[indexPath.row].totalday!) + " " + LocalizationSystem.sharedInstance.localizedStringForKey(key: "days", comment: "").localiz()
                } else {
                    cell.totalDaysLbl.text = String(describing: property_list[indexPath.row].totalday!) + " " + LocalizationSystem.sharedInstance.localizedStringForKey(key: "day", comment: "").localiz()
                }
                
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
//        }
//    else {
//            getPropertiesForDate(page: 1)
//        }
        
        return cell
    }
    
}

// For Prefetching
//extension BookingViewController: UITableViewDataSourcePrefetching {
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//
//        // fetch News from API for those rows that are being prefetched (near to visible area)
//        for indexPath in indexPaths {
//            if indexPath.row == property_list.count {
//                currentPage += 1
//                self.fetchProperties(ofIndex: currentPage)
//
//            }
//
//            print("\(indexPath)")
//
//        }
//
//
//      }
//
//      func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//
//        // cancel the task of fetching news from API when user scroll away from them
//        for indexPath in indexPaths {
//            if indexPath.row == property_list.count {
//                self.cancelFetchProperties(ofIndex: indexPath.row)
//            }
//        }
//      }
//}

extension BookingViewController: SlideTapDelegate {
    func didTapSlideShow(index: Int) {
        id = property_list[index].id!
        performSegue(withIdentifier: "showDetails", sender: id)
    }
    
}
