//
//  SearchViewController.swift
//  SkaudAssignment
//
//  Created by Manish Sharma on 06/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewSpinner: UIView!
    let userdefaults = UserDefaults.standard
    var arrRecentlySearched = [String]()
    let imageResources: ImageResources = ImageResources()
    let search = UISearchController(searchResultsController: nil)
    
    // MARK: - View Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding search controller
        addSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.reloadData()
        self.search.searchBar.text = ""
    }
    
    // MARK: - UISearchContoller
    func addSearchController() {
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type here to search images"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
    }
    
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            // search api
            showSpinner()
            let queryRequest = QueryRequest(q: searchText)
            imageResources.getImages(request: queryRequest, keyword: searchText) { (response) in
                if response?.total == 0 {
                    // search keyword not found
                    self.hideSpinner()
                    DispatchQueue.main.async {
                        self.tableView.isHidden = true
                    }
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "No results found", message: "Please try different keyword", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                            self.search.searchBar.text = ""
                            self.search.searchBar.searchTextField.becomeFirstResponder()
                            self.tableView.isHidden = false
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    // Navigation to next screen
                    self.arrRecentlySearched.insert(searchText, at: 0)
                    var lastTenArray = [String]()
                    // array with 10 elements only
                    if self.arrRecentlySearched.count > 10 {
                        for index in 0..<10 {
                            lastTenArray.append(self.arrRecentlySearched[index])
                        }
                        self.arrRecentlySearched = lastTenArray
                    }

                    self.userdefaults.set(self.arrRecentlySearched.removingDuplicates(), forKey: UserDefaultKeys.lastTenResult)
                    self.hideSpinner()
                    self.navigateToImage(with: searchText)
                }
            }
        }
        searchBar.resignFirstResponder()
    }
  
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let searchList = userdefaults.value(forKey: UserDefaultKeys.lastTenResult) as? [String] {
            if searchList.count > 0 {
                self.arrRecentlySearched = searchList
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        arrRecentlySearched.removeAll()
        self.tableView.reloadData()
    }
}
