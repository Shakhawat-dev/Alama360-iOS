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


class CellClass: UITableViewCell{
    
}

class SearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var titlePropertyAuto: SearchTextField!
    @IBOutlet weak var chaletCategoryField: UITextField!
    @IBOutlet weak var startDateField: UITextField!
    @IBOutlet weak var categoryDropDown: DropDown!
    @IBOutlet weak var addChaletLabel: UILabel!
    
    @IBOutlet weak var categoryDropDownBtn: UIButton!
    @IBOutlet weak var checkBtb: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var lblSearchTitle: UILabel!
    @IBOutlet weak var lblSearchDesc: UILabel!
    @IBOutlet weak var lblSelectDate: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    
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
        overrideUserInterfaceStyle = .light //For light mode
        // For Hiding keyboard on Tap
        self.hideKeyboardWhenTappedAround()
        
        setLocalize()
        loadProperties()
        loadCategories()
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
        
        //     startDateField.inputView = datePicker
        
        // In loadView or viewDidLoad
        //        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        //        calendar.dataSource = self as? FSCalendarDataSource
        //        calendar.delegate = self as? FSCalendarDelegate
        //        startDateField.inputView = calendar
        //        self.calendar = calendar
    }
    
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
                let titleCate = (title : titlePropertyAuto.text,  cate: arr_id[categoryDropDown.selectedIndex!], thumbcate: "" )
                print(titleCate)
                performSegue(withIdentifier: "openCalender", sender: titleCate)
            } else {
                let titleCate = (title : titlePropertyAuto.text,  cate: categoryDropDown.text, thumbcate: "")
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
        print("lan is \(lan)")
        
        let tUrl = StaticUrls.BASE_URL_FINAL + "daily-rental/for-rent?page=1&lang=" + lan + "&viewType=mapview"
        print("Title list Url is \(tUrl)")
        
        Alamofire.request(tUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                self.arr_tid.removeAll()
                self.arr_title.removeAll()
                
                // print(resultArray)
                for i in resultArray.arrayValue {
                    let id = i["id"].stringValue
                    self.arr_tid.append(id)
                    
                    let title = i["title"].stringValue
                    self.arr_title.append(title)
                    
                }
                
                self.titlePropertyAuto.filterStrings(self.arr_title)
                self.titlePropertyAuto.maxResultsListHeight = 200
                self.titlePropertyAuto.theme.font = UIFont.systemFont(ofSize: 14)
                self.titlePropertyAuto.theme.cellHeight = 40
                
                print(self.arr_title)
                print(self.arr_title.count)
            }
            
        }
        
    }
    
    // Bottom Property list
    func loadProperties() {
        
        // https://alama360.net/api/homethumbcat?page=1&lang=en
        
//        let lan = defaults.string(forKey: "language") ?? ""
        print("lan is \(lan)")
        
        let pUrl = StaticUrls.BASE_URL_FINAL + "homethumbcat?page=1&lang=" + lan
        print("lan is \(pUrl)")
        
        Alamofire.request(pUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                self.arr_cateName.removeAll()
                self.arr_imageUrl.removeAll()
                self.thumbId.removeAll()
                
                print(resultArray)
                
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
                
                print(self.arr_cateName)
                print(self.arr_cateName.count)
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
        
        cell.thumbImage.image = getImage(from: self.arr_imageUrl[indexPath.row])
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
        
        
        print("lan is \(lan)")
        
        let cUrl = "https://alama360.com/api/getLookUpByCat/80?lang=" + lan + "&limit=10"
        
        print("Category cUrl is \(cUrl)")
        
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
                
                print(self.arr_col1)
                print(self.arr_col1.count)
                
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
            destVC.titleCate = sender as? (title: String, cate: String, thumbcate: String)
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




