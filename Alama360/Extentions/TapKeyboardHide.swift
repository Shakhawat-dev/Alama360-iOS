//
//  TapKeyboardHide.swift
//  Alama360
//
//  Created by Alama360 on 09/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
