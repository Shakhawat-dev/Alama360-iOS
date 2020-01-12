//
//  MenuBar.swift
//  Alama360
//
//  Created by Alama360 on 16/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
//    UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = #colorLiteral(red: 0.02439633612, green: 0.6269035533, blue: 0.4417837247, alpha: 1)
//        cv.delegate = self
//        cv.dataSource = self

        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
}
