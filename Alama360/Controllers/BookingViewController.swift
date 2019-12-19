//
//  BookingViewController.swift
//  Alama360
//
//  Created by Alama360 on 21/04/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {

    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var mapSortContainerView: UIView!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    var originalDataSource: [String] = []
    var currentDataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ADDING array data to table view
        addProductToDataSource(productCount: 25, product: "Chalets")
        addProductToDataSource(productCount: 20, product: "Hotels")
        addProductToDataSource(productCount: 20, product: "something")
//
        tableView.delegate = self
        tableView.dataSource = self
//
        currentDataSource = originalDataSource
//
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        // For search view focus
        searchController.obscuresBackgroundDuringPresentation = false
        searchContainerView.addSubview(searchController.searchBar)
        searchController.searchBar.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    // Recieving and Showing data
    func addProductToDataSource(productCount: Int, product: String) {
        
        for index in 1...productCount {
            
            originalDataSource.append("\(product) #\(index)")
            
        }
        
    }
    
    // Search Filtering
    func filteringCurrentDataSource (searchTerm: String) {
        
        if searchTerm.count > 0 {
            
            currentDataSource = originalDataSource
            
            let filteredResult = currentDataSource.filter {
                $0.replacingOccurrences(of: " ", with: "").lowercased().contains(searchTerm.replacingOccurrences(of: " ", with: "").lowercased())
            }
            
            currentDataSource = filteredResult
            tableView.reloadData()
            
        }
        
    }
    
    func restoreCurrentDataSource() {
        currentDataSource = originalDataSource
        tableView.reloadData()
    }
    
    @IBAction func mapBtnClicked(_ sender: UIButton) {
        
    }
    @IBAction func sortBtnClicked(_ sender: UIButton) {
        
    }
    

}

extension BookingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text {
            filteringCurrentDataSource(searchTerm: searchText)
        }
        
    }

}

extension BookingViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.isActive = false
        
        if let searchText = searchBar.text {
            filteringCurrentDataSource(searchTerm: searchText)
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchController.isActive = false
        restoreCurrentDataSource()
        if let searchText = searchBar.text, !searchText.isEmpty {
            restoreCurrentDataSource()
        }
    }
    
}

extension BookingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "Selection", message: "Selected: \(currentDataSource[indexPath.row])", preferredStyle: .alert)
        
        searchController.isActive = false
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Use Always current DataSource
        return currentDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = currentDataSource[indexPath.row]
        return cell
    }
    
}
