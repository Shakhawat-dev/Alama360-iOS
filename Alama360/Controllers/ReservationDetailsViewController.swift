//
//  ReservationDetailsViewController.swift
//  Alama360
//
//  Created by Alama360 on 15/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class ReservationDetailsViewController: UIViewController {
    
    @IBOutlet weak var reservationDetailsTableView: UITableView!
    @IBOutlet weak var completeReservationBtn: CustomBtnGreen!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func completeReservationTapped(_ sender: Any) {
    }
    
}

extension ReservationDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
