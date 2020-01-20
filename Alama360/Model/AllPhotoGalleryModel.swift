//
//  AllPhotoGalleryModel.swift
//  Alama360
//
//  Created by Alama360 on 25/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import ImageSlideshow

struct AllPhotoGalleryModel {
    let photos = [String]()
    
    let image: UIImage

    var inputSource: InputSource {
        return ImageSource(image: image)
    }
}
