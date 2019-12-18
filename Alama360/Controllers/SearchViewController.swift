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



class CellClass: UITableViewCell{
    
}

class SearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var titlePropertyAuto: SearchTextField!
    @IBOutlet weak var chaletCategoryField: UITextField!
    @IBOutlet weak var startDateField: UITextField!
    @IBOutlet weak var categoryDropDown: DropDown!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var categoryDropDownBtn: UIButton!
    @IBOutlet weak var checkBtb: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let defaults = UserDefaults.standard
    
    let transparentVIew = UIView()
    let categoryTableView = UITableView()
    private var datePicker: UIDatePicker?
    
    
    let Url = "https://alama360.net/api/"
    var thumbImage = [UIImage]()
    var arr_cateName = [String]()
    var arr_imageUrl = [String]()
    
    var arr_id = [String]()
    var arr_col1 = [String]()
    
    var arr_tid = [String]()
    var arr_title = [String]()
    
    var dataSource = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        categoryTableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
        
        loadProperties()
        loadCategories()
        loadPropertyTitle()
//        datePickerTapped()
        getDatePicker()
        
        //
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.viewTapped(gestureRecognizer:)))
        
        //        view.addGestureRecognizer(tapGesture)
        
        //        startDateField.inputView = datePicker
    }
    
    func getDatePicker() {
        
        startDateField.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        
        
        //        datePicker = UIDatePicker()
        //                datePicker?.locale = NSLocale.init(localeIdentifier: "ar") as Locale
        //
        //                datePicker?.datePickerMode = .date
        //                datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        //        //
        //        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.viewTapped(gestureRecognizer:)))
        //
        //        //        view.addGestureRecognizer(tapGesture)
        //
        //                startDateField.inputView = datePicker
        
        
        //    @objc func viewTapped (gestureRecognizer: UITapGestureRecognizer) {
        //        view.endEditing(true)
        //    }
        //
        
    }
    
    //    new
    @objc func myTargetFunction(textField: UITextField) {
        print("myTargetFunction")
//
//            DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
//                (date) -> Void in
//                if let dt = date {
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "MM/dd/yyyy"
//                    self.startDateField.text = formatter.string(from: dt)
//                }
//            }
        
    }
    
    
    //    @objc func viewTapped (gestureRecognizer: UITapGestureRecognizer) {
    //        view.endEditing(true)
    //    }
    //
//    @objc func dateChanged(datePicker: UIDatePicker) {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        startDateField.text = dateFormatter.string(from: datePicker.date)
//        view.endEditing(true)
//
//    }
    
    @IBAction func checkBtnPressed(_ sender: UIButton) {
//        func datePickerTapped() {
//            DatePickerDialog().show( "DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
//                (date) -> Void in
//                if let dt = date {
//                            let formatter = DateFormatter()
//                            formatter.dateFormat = "MM/dd/yyyy"
//                            self.startDateField.text = formatter.string(from: dt)
//                        }
//            }
//        }
        
//        DatePickerDialog().show("DatePickerDialog", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) { (date) in
//            if let dt = date {
//                 let formatter = DateFormatter()
//                  formatter.dateFormat = "dd.MM.yyyy" // change format as per your needs
//                  self.startDateField.text = formatter.string(from:dt)
//            }
//        }
    }
    
    @IBAction func categoryBtnPressed(_ sender: UIButton) {
        
        //        arr_col1 = ["",""]
        //        addTransparentView(frames: categoryDropDownBtn.frame)
        
    }
    
    @IBAction func startDateClicked(_ sender: Any) {
        
        
        
    }
    
    // Load proerty Titles Auto
    func loadPropertyTitle() {
        
        let lan = defaults.string(forKey: "language") ?? ""
        print("lan is \(lan)")
        
        let tUrl = Url + "daily-rental/for-rent?page=1&lang=" + lan + "&viewType=mapview"
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
        
        let lan = defaults.string(forKey: "language") ?? ""
        print("lan is \(lan)")
        
        let pUrl = Url + "homethumbcat?page=1&lang=" + lan
        print("lan is \(pUrl)")
        
        Alamofire.request(pUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
            
            if mysresponse.result.isSuccess {
                
                let myResult = try? JSON(data: mysresponse.data!)
                let resultArray = myResult!["data"]
                
                self.arr_cateName.removeAll()
                self.arr_imageUrl.removeAll()
                
                // print(resultArray)
                for i in resultArray.arrayValue {
                    let cateName = i["catname"].stringValue
                    self.arr_cateName.append(cateName)
                    
                    let imageUrl = i["thumbnail"].stringValue
                    self.arr_imageUrl.append(imageUrl)
                    
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
        guard let url = URL(string: string)
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
    
    // Getting categories from Api
    func loadCategories() {
        
        // https://alama360.com/api/getLookUpByCat/80?lang=en&limit=10
        
        let lan = defaults.string(forKey: "language") ?? ""
        
        
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
                //
                //                self.categoryDropDown.didSelect{(selectedText , index ,id) in
                //                    self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
                //
                //
                //                }
                
                
                // Need to call table view here...
                //                self.categoryTableView.register(CellClass.self, forCellReuseIdentifier: "Cell")
                //                self.categoryTableView.delegate = self
                //                self.categoryTableView.dataSource = self
                
                print(self.arr_col1)
                print(self.arr_col1.count)
                
                
                
            }
            
            
        }
        
    }
    
    @IBAction func datepickerclicked(_ sender: UITextField) {
    }
    
    
    
    //    // Transparent effect if button clicked
    //    func addTransparentView(frames: CGRect) {
    //        let window = UIApplication.shared.keyWindow
    //        transparentVIew.frame = window?.frame ?? self.view.frame
    //        self.view.addSubview(transparentVIew)
    //
    //        categoryTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
    //        self.view.addSubview(categoryTableView)
    //
    //        categoryTableView.layer.cornerRadius = 5
    //
    //        transparentVIew.backgroundColor = UIColor.black.withAlphaComponent(0.9)
    //        categoryTableView.reloadData()
    //
    //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
    //        transparentVIew.addGestureRecognizer(tapGesture)
    //
    //        transparentVIew.alpha = 0
    //
    //        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
    //            self.transparentVIew.alpha = 0.5
    //            self.categoryTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 80))
    //        }, completion: nil)
    //    }
    //
    //    @objc func removeTransparentView() {
    //        let frames = categoryDropDownBtn.frame
    //
    //        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
    //            self.transparentVIew.alpha = 0
    //            self.categoryTableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
    //        }, completion: nil)
    //    }
    
    
    // AUto Complete
}

// The parent view controller
//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arr_col1.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = arr_col1[indexPath.row]
//
//        return cell
//
//    }
//
//    // for row height
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        categoryDropDownBtn.setTitle(arr_col1[indexPath.row], for: .normal)
//        removeTransparentView()
//    }
//
//}


