//
//  OtpAlertView.swift
//  Alama360
//
//  Created by Alama360 on 04/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import Foundation
import UIKit

class OtpAlertView: UIView {
    
    static let instance = OtpAlertView()
    
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var textInputField: UITextField!
    @IBOutlet weak var actionBtn: CustomBtnGreen!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("OTPalertView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func showAlert(title: String, message: String) {
        self.titleText.text = title
        self.messageText.text = message
    }
    
    
    
}
