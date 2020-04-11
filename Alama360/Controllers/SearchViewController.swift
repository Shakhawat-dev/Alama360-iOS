//
//  SearchViewController.swift
//  Alama360
//
//  Created by Alama360 on 12/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SearchTextField
import iOSDropDown
import LanguageManager_iOS
import FSCalendar
import AlamofireImage


class CellClass: UITableViewCell{
    
}

class SearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var textFieldContainerView: UIView!
    @IBOutlet weak var titlePropertyAuto: SearchTextField!
    @IBOutlet weak var startDateField: UITextField!
    @IBOutlet weak var categoryDropDown: DropDown!
    @IBOutlet weak var stateDropDown: DropDown!
    @IBOutlet weak var cityDropDown: DropDown!
    @IBOutlet weak var districtDropDown: DropDown!
    @IBOutlet weak var addChaletLabel: UILabel!
    @IBOutlet weak var checkBtb: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblSearchTitle: UILabel!
    @IBOutlet weak var lblSearchDesc: UILabel!
    @IBOutlet weak var lblSelectDate: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var addYourChaletContainerView: UIView!
    @IBOutlet weak var addChaletIcon: UIImageView!
    
    // Fs Calender
    fileprivate weak var calendar: FSCalendar!
    
    let defaults = UserDefaults.standard
    let lan = LanguageManager.shared.currentLanguage.rawValue
    
    let transparentVIew = UIView()
    let categoryTableView = UITableView()
    private var datePicker: UIDatePicker?
    
    
    let Url = "https://alama360.com/api/"
    var thumbImage = [UIImage]()
    var arr_cateName = [String]()
    var arr_imageUrl = [String]()
    var arr_stateId = [Int]()
    var arr_stateName = [String]()
    var arr_cityId = [Int]()
    var arr_cityName = [String]()
    var arr_districtId = [Int]()
    var arr_districtName = [String]()
    var thumbId = [String]()
    
    var arr_id = [String]()
    var arr_col1 = [String]()
    
    var arr_tid = [String]()
    var arr_title = [String]()
    
    var dataSource = [String]()
    var sDates: [Date]?
    var starDate: String = ""
    var endDate: String = ""
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        // For Hiding keyboard on Tap
        self.hideKeyboardWhenTappedAround()
        
        addDesign()
        setLocalize()
        loadProperties()
        loadCategories()
        loadStates()
        loadPropertyTitle()
        getDatePicker()
        
        self.startDateField.delegate = self
        
        let logo = #imageLiteral(resourceName: "logo")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        if sDates != nil {
            starDate = formatter.string(from: (sDates?.first)!)
            endDate = formatter.string(from: (sDates?.last)!)
            
            setDateField()
        }
        
        

    }
    
    func addDesign() {
        
        addChaletIcon.image = #imageLiteral(resourceName: "icons8-home-page-100")
        
        searchContainerView.layer.cornerRadius = 8
        searchContainerView.layer.shadowRadius = 8
        searchContainerView.layer.shadowOpacity = 0.5
        searchContainerView.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        searchContainerView.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        textFieldContainerView.layer.cornerRadius = 8
//        textFieldContainerView.layer.shadowRadius = 8
//        textFieldContainerView.layer.shadowOpacity = 1.0
//        textFieldContainerView.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
//        textFieldContainerView.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//
        addYourChaletContainerView.layer.cornerRadius = 8
        addYourChaletContainerView.layer.shadowRadius = 8
        addYourChaletContainerView.layer.shadowOpacity = 0.5
        addYourChaletContainerView.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        addYourChaletContainerView.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
//     params.put("filterstateid", stateId);
//                   params.put("filtercityid", cityId);
//                   params.put("filterdistrictid", districtId);
    func setLocalize() {
        lblSearchTitle.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "lvl_search_header", comment: "").localiz()
        lblSearchDesc.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "for_an_apartment", comment: "").localiz()
        checkBtb.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "lvl_search", comment: "").localiz(), for: .normal)
        addChaletLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "add_your_chalat", comment: "").localiz()
        lblSelectDate.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_appropriate_date", comment: "").localiz()
        btnAdd.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "add_now", comment: "").localiz(), for: .normal)
        
        titlePropertyAuto.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "property_title", comment: "").localiz()
        categoryDropDown.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "search_category", comment: "").localiz()
        startDateField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "start_date", comment: "").localiz()
        
    
        stateDropDown.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_state", comment: "").localiz()
        

        cityDropDown.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_city", comment: "").localiz()
        cityDropDown.isHidden=true
        
        districtDropDown.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_district", comment: "").localiz()
        districtDropDown.isHidden=true
        
    }
    
    func getDatePicker() {
        
        //        datePicker = UIDatePicker()
        //        datePicker?.locale = NSLocale.init(localeIdentifier: "ar") as Locale
        //
        //        datePicker?.datePickerMode = .date
        //        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        //
        //        startDateField.inputView = datePicker
 
    }

    @objc func dateChanged(datePicker: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        startDateField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        
    }
    
    @IBAction func checkBtnPressed(_ sender: UIButton) {
        if startDateField.text == "" {
            if categoryDropDown.text != "" {
                let titleCate = (title : titlePropertyAuto.text,
                                 cate: arr_id[categoryDropDown.selectedIndex!],
                                 thumbcate: "",
                                 state_id: arr_stateId[stateDropDown.selectedIndex!],
                                 city_id: arr_cityId[cityDropDown.selectedIndex!],
                                 dist_id: arr_districtId [districtDropDown.selectedIndex!])
                print(titleCate)
                performSegue(withIdentifier: "openCalender", sender: titleCate)
            } else {
                let titleCate = (title : titlePropertyAuto.text,
                                 cate: categoryDropDown.text,
                                 thumbcate: "",
                                 state_id: arr_stateId[stateDropDown.selectedIndex ?? 0],
                                 city_id: arr_cityId[cityDropDown.selectedIndex ?? 0],
                                 dist_id: arr_districtId [districtDropDown.selectedIndex ?? 0])
                print(titleCate)
                performSegue(withIdentifier: "openCalender", sender: titleCate)
            }
            
        }
    }
    
    @IBAction func addPropertyTapped(_ sender: Any) {
        performSegue(withIdentifier: "addPropertySegue", sender: nil)
    }
    
    @IBAction func startDateClicked(_ sender: Any) {
        
    }
    
    // Load proerty Titles Auto
    func loadPropertyTitle() {
        
//        let lan = defaults.string(forKey: "language") ?? ""
       // print("lan is \(lan)")
        
        let tUrl = StaticUrls.BASE_URL_FINAL + "autocomplete/alltitle?lang=\(lan)"
      //  print("Title list Url is \(tUrl)")
        
        Alamofire.request(tUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
//                self.arr_tid.removeAll()
                self.arr_title.removeAll()
                
                // print(resultArray)
                for i in resultArray.arrayValue {
//                    let id = i["id"].stringValue
//                    self.arr_tid.append(id)
                    
                    let title = i["title"].stringValue
                    self.arr_title.append(title)
                    
                }
                
                self.titlePropertyAuto.filterStrings(self.arr_title)
                self.titlePropertyAuto.maxResultsListHeight = 200
                self.titlePropertyAuto.theme.font = UIFont.systemFont(ofSize: 14)
                self.titlePropertyAuto.theme.cellHeight = 40
                
//                print(self.arr_title)
//                print(self.arr_title.count)
            }
            
        }
        
    }
    
    // Bottom Property list
    func loadProperties() {
        
        // https://alama360.net/api/homethumbcat?page=1&lang=en
        
//        let lan = defaults.string(forKey: "language") ?? ""
//        print("lan is \(lan)")
        
        let pUrl = StaticUrls.BASE_URL_FINAL + "homethumbcat?page=1&lang=" + lan
       // print("lan is \(pUrl)")
        
        Alamofire.request(pUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                self.arr_cateName.removeAll()
                self.arr_imageUrl.removeAll()
                self.thumbId.removeAll()
                
//                print(resultArray)
                
                for i in resultArray.arrayValue {
                    let cateName = i["catname"].stringValue
                    self.arr_cateName.append(cateName)
                    
                    let imageUrl = i["thumbnail"].stringValue
                    self.arr_imageUrl.append(imageUrl)
                    
                    let thId = i["id"].stringValue
                    self.thumbId.append(thId)
                    
                }
                
                self.collectionView.dataSource = self
                self.collectionView.delegate = self
                self.collectionView.reloadData()
                
//                print(self.arr_cateName)
//                print(self.arr_cateName.count)
            }
            
        }
        
    }
    
    // Getting image form Json URL
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
    
    // Showing Horizantal property list for Search
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr_cateName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCell
        
//        cell.thumbImage.image = getImage(from: self.arr_imageUrl[indexPath.row])
        cell.thumbImage.af_setImage(withURL: URL(string: self.arr_imageUrl[indexPath.row].addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!)
        cell.categoryTitle.text = self.arr_cateName[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if thumbId[indexPath.row] != "" {
            let titleCate = (title : titlePropertyAuto.text,  cate: categoryDropDown.text, thumbcate: thumbId[indexPath.row] )
            print(titleCate)
            performSegue(withIdentifier: "openCalender", sender: titleCate)
        }
    }
    
    // Getting categories from Api
    func loadCategories() {
        
        // https://alama360.com/api/getLookUpByCat/80?lang=en&limit=10
        
//        let lan = defaults.string(forKey: "language") ?? ""
        
        
        //print("lan is \(lan)")
        
        let cUrl = "https://alama360.com/api/getLookUpByCat/80?lang=" + lan + "&limit=10"
        
       // print("Category cUrl is \(cUrl)")
        
        Alamofire.request(cUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                
                let resultArray = myResult![]
                
                self.arr_id.removeAll()
                self.arr_col1.removeAll()
                
                // print(resultArray)
                
                for i in resultArray.arrayValue {
                    let id = i["id"].stringValue
                    self.arr_id.append(id)
                    
                    let col1 = i["col1"].stringValue
                    self.arr_col1.append(col1)
                    
                }
                
                self.categoryDropDown.optionArray = self.arr_col1
                
//                print(self.arr_col1)
//                print(self.arr_col1.count)
                
            }

        }
        
    }
    
    // Getting States from Api
        func loadStates() {
            
            let sUrl = "https://www.alama360.com/android/Locations.php?lang=\(lan)&type=state&parent1=191"
            
          //  print("State Url is \(sUrl)")
            
            Alamofire.request(sUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
                
                if mysresponse.result.isSuccess {
                    
                    let myResult = try? JSON(data: mysresponse.data!)
                    
                    let resultArray = myResult!["locations"]
                    
                    self.arr_stateId.removeAll()
                    self.arr_stateName.removeAll()
                    
                     print(resultArray)
                    
                    for i in resultArray.arrayValue {
                        let state_id = i["state_id"].intValue
                        self.arr_stateId.append(state_id)
                        
                        let name = i["name"].stringValue
                        self.arr_stateName.append(name)
                        
                    }
                    
                    self.stateDropDown.optionArray = self.arr_stateName
                    self.stateDropDown.optionIds = self.arr_stateId
                    
//                    print(self.arr_stateName)
//                    print(self.arr_stateName.count)
                    
                    self.stateDropDown.didSelect{(selectedText , index ,id) in
//                        self.cityDropDown.text = " \(selectedText) \n id: \(id)"
                        self.loadCities(id: id)
                        self.districtDropDown.isHidden=true
                    }
                    

                }

            }
            
        }
    
    // Getting States from Api
    func loadCities(id: Int) {
        self.cityDropDown.text = ""
        
        let cUrl = "https://www.alama360.com/android/Locations.php?lang=\(lan)&type=city&parent1=191&parent2=\(id)"
                
               // print("City Url is \(cUrl)")
                
                Alamofire.request(cUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
                    
                    if mysresponse.result.isSuccess {
                        
                        let myResult = try? JSON(data: mysresponse.data!)
                        
                        let resultArray = myResult!["locations"]
                        self.arr_cityId.removeAll()
                        self.arr_cityName.removeAll()                       //  print(resultArray)
                        
                        for i in resultArray.arrayValue {
                            let city_id = i["city_id"].intValue
                            self.arr_cityId.append(city_id)
                            
                            let name = i["name"].stringValue
                            self.arr_cityName.append(name)
                            
                        }
                        
                        if resultArray.isEmpty {
                            self.cityDropDown.isHidden=true
                        }else{
                            self.cityDropDown.isHidden=false
                        }
                        
                        self.cityDropDown.optionArray = self.arr_cityName
                        self.cityDropDown.optionIds = self.arr_cityId
//
//                        print(self.arr_cityName)
//                        print(self.arr_cityId.count)
                        
                        self.cityDropDown.didSelect{(selectedText , index ,id) in
                            self.loadDistricts(id: id)
                           
                        }
                        

                    }

                }
                
            }
        
    func loadDistricts(id: Int) {
             self.districtDropDown.text = ""
        let dUrl = "https://www.alama360.com/android/Locations.php?lang=\(lan)&type=district&parent1=191&parent3=\(id)"
                
                Alamofire.request(dUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
                    
                    if mysresponse.result.isSuccess {
                        
                        let myResult = try? JSON(data: mysresponse.data!)
                        
                        let resultArray = myResult!["locations"]
                        
                        self.arr_districtId.removeAll()
                        self.arr_districtName.removeAll()
                        
                        for i in resultArray.arrayValue {
                            let district_id = i["district_id"].intValue
                            self.arr_districtId.append(district_id)
                            
                            let name = i["name"].stringValue
                            self.arr_districtName.append(name)
                            
                        }
                        if resultArray.isEmpty {
                            self.districtDropDown.isHidden=true
                        }else{
                            self.districtDropDown.isHidden=false
                        }
                        self.districtDropDown.optionArray = self.arr_districtName
                        self.districtDropDown.optionIds = self.arr_districtId

                    }

                }
                
            }
    
    
    
    func setDateField () {
        print("From set method \(starDate + endDate)")
        startDateField.text = starDate + " to " + endDate
        
    }
    
    // Sending Data to View COntroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openCalender" {
            let destVC = segue.destination as! FCalenderViewController
            destVC.titleCate = sender as? (title: String, cate: String, thumbcate: String, state_id: Int, city_id: Int, district_id: Int)
        }
//        if segue.identifier == "addPropertySegue" {
//            let destVC = segue.destination as! AddPropertyViewController
//            destVC.addProperty()
//        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool   {
        //Load your VC here
        if categoryDropDown.text != "" {
            let titleCate = (title : titlePropertyAuto.text,  cate: arr_id[categoryDropDown.selectedIndex!], thumbcate: "" )
            print(titleCate)
            performSegue(withIdentifier: "openCalender", sender: titleCate)
        } else {
            let titleCate = (title : titlePropertyAuto.text,  cate: categoryDropDown.text, thumbcate: "" )
            print(titleCate)
            performSegue(withIdentifier: "openCalender", sender: titleCate)
        }
        
        
        
        return false
    }
    
    
}

extension SearchViewController: PassDateToVC {
    func passDate(dates: [Date]) {
        sDates = dates
    }
}




