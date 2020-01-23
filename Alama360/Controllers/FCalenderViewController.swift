//
//  FCalenderViewController.swift
//  Alama360
//
//  Created by Alama360 on 28/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import FSCalendar

class FCalenderViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    @IBOutlet weak var calendar: FSCalendar!
    
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
//    override func loadView() {
//
//        calendar.dataSource = self
//        calendar.delegate = self
//        calendar.allowsMultipleSelection = true
//
//        calendar.today = nil // Hide the today circle
//        calendar.register(DIYCalenderCell.self, forCellReuseIdentifier: "cell")
//        //        calendar.clipsToBounds = true // Remove top/bottom line
//
//        calendar.swipeToChooseGesture.isEnabled = true // Swipe-To-Choose
//
//        let scopeGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)));
//        calendar.addGestureRecognizer(scopeGesture)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        calendar.dataSource = self
        calendar.delegate = self
        calendar.allowsMultipleSelection = true
        calendar.register(DIYCalenderCell.self, forCellReuseIdentifier: "cell")
         calendar.swipeToChooseGesture.isEnabled = true // Swipe-To-Choose
        
        let scopeGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)));
        calendar.addGestureRecognizer(scopeGesture)
        
        
//        let dates = [
//            self.gregorian.date(byAdding: .day, value: -1, to: Date()),
//            Date(),
//            self.gregorian.date(byAdding: .day, value: 1, to: Date())
//        ]
//        dates.forEach { (date) in
//            self.calendar.select(date, scrollToDate: false)
//        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Disables selecting previous dates
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if  formatter.string(from: calendar.today!) > formatter.string(from: date) {
            return false
        }

        return true
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.formatter.string(from: date))")
//        self.configureVisibleCells()
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        print("did deselect date \(self.formatter.string(from: date))")
//        self.configureVisibleCells()
    }
}
