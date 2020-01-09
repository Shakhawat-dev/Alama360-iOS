//
//  AllPhotosViewController.swift
//  Alama360
//
//  Created by Alama360 on 13/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class AllPhotosViewController: UIViewController {

    var allPhotos: PhotosModel?
    
    @IBOutlet weak var allphotoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        allphotoTableView.delegate = self
        allphotoTableView.dataSource = self
//        print("All photos VC: \(allPhotos!)")
        
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

}

extension AllPhotosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllPhotosCell") as! AllPhotosCell
        
        cell.cellPhoto.image = getImage(from: (allPhotos?.picture[indexPath.row])!)
        
        return cell
    }
    
    
}
