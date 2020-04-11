//
//  FCalenderViewController.swift
//  Alama360
//
//  Created by Alama360 on 28/05/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit
import FSCalendar

protocol PassDateToVC {
    func passDate(dates: [Date])
}

class FCalenderViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var okBtn: CustomBtnGreen!
    @IBOutlet weak var clearBtn: CustomBtnGreen!
    
    //For storing user data
    let defaults = UserDefaults.standard
    
    var titleCate : (title: String, cate: String, thumbcate: String, state_id: Int, city_id: Int, district_id: Int)?
    
    // first date in the range
    private var firstDate: Date?
    // last date in the range
    private var lastDate: Date?
    private var datesRange: [Date]?
    
    //    var datesRange: [Dates]?
    
    var fDate: String = ""
    var lDate: String = ""
    
    var delegate: PassDateToVC?
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        setLocalize()
        
//        print("From FS Cal\(titleCate)")
        
        calendar.dataSource = self
        calendar.delegate = self
        //        calendar.today = nil // Hide the today circle
        calendar.allowsMultipleSelection = true
        calendar.register(DIYCalenderCell.self, forCellReuseIdentifier: "cell")
        calendar.swipeToChooseGesture.isEnabled = true // Swipe-To-Choose
        
        
        let scopeGesture = UIPanGestureRecognizer(target: calendar, action: #selector(calendar.handleScopeGesture(_:)));
        calendar.addGestureRecognizer(scopeGesture)
        
    }
    
    func setLocalize() {
        
        okBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "cOk", comment: "").localiz(), for: .normal)
        clearBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "btnClear", comment: "").localiz(), for: .normal)
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }
        
        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        
        return array
    }
    
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
        
        
        // nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            
//            print("datesRange contains: \(datesRange!)")
            
            return
        }
        
        // only first date is selected:
        if firstDate != nil && lastDate == nil {
            // handle the case of if the last date is less than the first date:
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                
//                print("datesRange contains: \(datesRange!)")
                
                return
            }
            
            let range = datesRange(from: firstDate!, to: date)
            
            lastDate = range.last
            
            for d in range {
                calendar.select(d)
            }
            
            datesRange = range
            
//            print("datesRange contains: \(datesRange!)")
            
            return
        }
        
        // both are selected:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            
//            print("datesRange contains: \(datesRange!)")
        }
        
//        print("did select date \(self.formatter.string(from: date))")
    }
    
    @IBAction func clearBtnTapped(_ sender: UIButton) {
        for d in calendar.selectedDates {
            calendar.deselect(d)
        }
        
        lastDate = nil
        firstDate = nil
        
        datesRange = []
        
//        print("datesRange contains: \(datesRange!)")
    }
    
    // Sending Data to View COntroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calToPropSegue" {
            let destVC = segue.destination as! BookingViewController
            destVC.propParam = sender as? (title: String, cate: String, thumbcate: String, startDate: String, endDate: String, state_id: Int, city_id: Int, district_id: Int)
        }

    }
    
    @IBAction func okBtnTapped(_ sender: UIButton) {
        
        if datesRange?.first != nil {
            fDate = formatter.string(from: (datesRange?.first)!)
            lDate = formatter.string(from: (datesRange?.last)!)
            
            defaults.set(fDate, forKey: "firstDate")
            defaults.set(lDate, forKey: "lastDate")
            
            let propParam = (title : titleCate?.title, cate : titleCate?.cate, thumbcate: titleCate?.thumbcate, startDate: fDate, endDate: lDate, state_id: titleCate?.state_id, city_id: titleCate?.city_id, titleCate?.district_id )
//            print("property Param is : \(propParam)")
            performSegue(withIdentifier: "calToPropSegue", sender: propParam)
        } else {
            
            let aTitle = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cAlert_title", comment: "").localiz()
            let aMessage = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cAlert_message", comment: "").localiz()
            let aAction = LocalizationSystem.sharedInstance.localizedStringForKey(key: "cOk", comment: "").localiz()
            
            let alert = UIAlertController(title: aTitle, message: aMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: aAction, style: .default, handler: { _ in
//                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            
            //            Toast.show( message: "Please select Dates to proceed.", controller: self )
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        
        // NOTE: the is a REDUANDENT CODE:
        if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            lastDate = nil
            firstDate = nil
            
            datesRange = []
            print("datesRange contains: \(datesRange!)")
        }
        
//        print("did deselect date \(self.formatter.string(from: date))")
    }

}

