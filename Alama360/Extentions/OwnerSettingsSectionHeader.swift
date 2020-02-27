//
//  OwnerSettingsSectionHeader.swift
//  Alama360
//
//  Created by Alama360 on 03/07/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class OwnerSettingsSectionHeader: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var lblSectionName: UILabel!
    @IBOutlet weak var btnExpand: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    private func commitInit() {
        Bundle.main.loadNibNamed("OwnerSettingsSectionHeader", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
