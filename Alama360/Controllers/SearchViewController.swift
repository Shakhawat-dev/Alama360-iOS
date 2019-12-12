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

class SearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    @IBOutlet weak var propertyTitleField: UITextField!
    @IBOutlet weak var chaletCategoryField: UITextField!
    @IBOutlet weak var startDateField: UITextField!
    
    @IBOutlet weak var checkBtb: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let defaults = UserDefaults.standard
    
    
    let Url = "https://alama360.net/api/"
    var thumbImage = [UIImage]()
    var arr_cateName = [String]()
    var arr_imageUrl = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProperties()
        
        
        
//        var imageView = UIImageView();
//        var image = UIImage(named: "ic_district.png");
//        imageView.image = image;
//        imageView.sizeToFit()
//
//        propertyTitleField.leftView = imageView;
//        propertyTitleField.leftViewMode = UITextField.ViewMode.always
//        propertyTitleField.leftViewMode = .always
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkBtnPressed(_ sender: UIButton) {
        
    }
    
    // Bottom Property list
    func loadProperties() {
        
//        https://alama360.net/api/homethumbcat?page=1&lang=en
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
            
//            print(resultArray)
            
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            
            return self.arr_cateName.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCell
            
            //var url = NSURL.init(fileURLWithPath: self.arr_imageUrl[0])
            //var data = NSData(contentsOf : url as URL)
            //var image = UIImage(data: data as! Data)
            //var size = image.size
            cell.thumbImage.image = getImage(from: self.arr_imageUrl[indexPath.row])
            cell.categoryTitle.text = self.arr_cateName[indexPath.row]
            
            return cell
            
        }
}
