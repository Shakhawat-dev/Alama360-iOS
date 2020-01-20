//
//  AllPhotosViewController.swift
//  Alama360
//
//  Created by Alama360 on 13/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import SwiftyJSON

class AllPhotosViewController: UIViewController {

    var allPhotos: PhotosModel?
    var photos = [String?]()
    var id: String?
    var lan: String = ""
    
    @IBOutlet weak var allphotoTableView: UITableView!
    var slideshowTransitioningDelegate: ZoomAnimatedTransitioningDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if allPhotos!.picture != nil{
//            photos = allPhotos!.picture
//        }
        
        // Do any additional setup after loading the view.
//        allphotoTableView.delegate = self
//        allphotoTableView.dataSource = self
//        allphotoTableView.reloadData()
//        print("All photos VC: \(allPhotos!)")
//        let photos = allPhotos?.picture
        
        print("From All id is \(id)")
        getPropertyDetails()
    }
    
    // Get Api Call
        func getPropertyDetails() {
            
            lan = LocalizationSystem.sharedInstance.getLanguage()
            
//            let photoUrl = StaticUrls.BASE_URL_FINAL + "propertydetails/" + id + "?lang=" + lan + "&userid=124"
            let photoUrl = StaticUrls.BASE_URL_FINAL + "propertydetails/130?lang=" + lan + "&userid=124"
            
            // URL check
            print("Response bUrl is: \(photoUrl)")
            
            Alamofire.request(photoUrl, method: .get, headers: nil).responseJSON{ (mysresponse) in
                
                if mysresponse.result.isSuccess {
                    
                    let myResult = try? JSON(data: mysresponse.data!)
                    let resultArray = myResult!["data"]
                    
                    print(resultArray as Any)
                    
                    // Initiatoing resultArray into specific array

                    
                    let photoArray = resultArray["photos"]["photosaall"].arrayValue
                    let newPhoto = PhotosModel(json: JSON(photoArray))
                    self.allPhotos = newPhoto

                    self.photos = self.allPhotos!.picture
                    
                    print(self.photos)
                    
                    
                    
                    self.allphotoTableView.delegate = self
                    self.allphotoTableView.dataSource = self
                    self.allphotoTableView.reloadData()
                    
                    

    
                }
                
            }
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func photoInputs(photos: [String?]) -> [InputSource] {
        var inputSources = [InputSource]()
        for i in photos {

            let inputSource = ImageSource(image: getImage(from: i!)!)
            inputSources.append(inputSource)
        }

        return inputSources
    }

}

extension AllPhotosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        var count: Int?
//
//        if let allArr: [String?] = allPhotos?.picture {
//            count = allArr.count
//        }
        
//        print((allPhotos?.picture)!)
        
        return (allPhotos?.picture.count)!

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllPhotosCell") as! AllPhotosCell
        if let allArr: [String?] = allPhotos?.picture {
            cell.cellPhoto.image = getImage(from: allArr[indexPath.row]!)
        }
//        cell.cellPhoto.image = getImage(from: (allPhotos?.picture[0])!)
//        cell.cellPhoto.image = getImage(from: (allPhotos?.picture[1])!)
//        cell.cellPhoto.image = getImage(from: (allPhotos?.picture[2])!)
//        cell.cellPhoto.image = getImage(from: (allPhotos?.picture[3])!)
//        cell.cellPhoto.image = getImage(from: (allPhotos?.picture[4])!)
//        cell.cellPhoto.image = getImage(from: (allPhotos?.picture[5])!)
//        cell.cellPhoto.image = getImage(from: (allPhotos?.picture[6])!)
//        cell.cellPhoto.image = getImage(from: (allPhotos?.picture[7])!)
//        cell.cellPhoto.image = getImage(from: (allPhotos?.picture[8])!)
//        cell.cellPhoto.image = getImage(from: (allPhotos?.picture[9])!)
//        cell.cellPhoto.image = getImage(from: (allPhotos?.picture[10])!)
//        cell.cellPhoto.image = getImage(from: (photos[indexPath.row]))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let models = [AllPhotoGalleryModel(image: getImage(from: (allPhotos?.picture[indexPath.row])!)!)] // Works but single
        
        
        
        let fullScreenController = FullScreenSlideshowViewController()
//        var inputSources = [InputSource]()
//
//        let  inputSource = ImageSource(image: getImage(from: photos[indexPath.row]!)!)
//        inputSources.append(inputSource)
//        let  inputSource1 = ImageSource(image: getImage(from: photos[indexPath.row]!)!)
//        inputSources.append(inputSource1)
//        var inputSource: InputSource {
//            return ImageSource(image: image)
//        }
        
        let inputSources = photoInputs(photos: photos)
        
//        fullScreenController.inputs = models.map { $0.inputSource }
        fullScreenController.inputs = inputSources
        
//        fullScreenController.inputs = InputSource(getImage(from: (allPhotos?.picture[indexPath.row])!)!)
        fullScreenController.initialPage = indexPath.row
        
        if let cell = tableView.cellForRow(at: indexPath), let imageView = cell.imageView {
            slideshowTransitioningDelegate = ZoomAnimatedTransitioningDelegate(imageView: imageView, slideshowController: fullScreenController)
            fullScreenController.transitioningDelegate = slideshowTransitioningDelegate
        }
        
        fullScreenController.slideshow.currentPageChanged = { [weak self] page in
            if let cell = tableView.cellForRow(at: IndexPath(row: page, section: 0)), let imageView = cell.imageView {
                self?.slideshowTransitioningDelegate?.referenceImageView = imageView
            }
        }
        
        present(fullScreenController, animated: true, completion: nil)
    }
    
}
