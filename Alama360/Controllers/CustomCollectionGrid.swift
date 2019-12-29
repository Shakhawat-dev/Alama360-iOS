//
//  CustomCollectionGrid.swift
//  Alama360
//
//  Created by Alama360 on 02/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

protocol CustomCollectionDelegate: class {
    func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize
}

class CustomCollectionGrid: UICollectionViewLayout {
    
    weak var delegate: CustomCollectionDelegate!
    
    var numberOfcolumns = 2
    var cellPadding: CGFloat = 3
    
    fileprivate var cache = [UICollectionViewLayoutAttributes] ()
    
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        
        return collectionView.bounds.width
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
}
