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
    let userdefaults = UserDefaults.standard
    var arrRecentlySearched = [String]()
    let imageResources: ImageResources = ImageResources()
    let search = UISearchController(searchResultsController: nil)
    @IBOutlet weak var viewSpinner: UIView!
    
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
                    self.tableView.isHidden = false
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

                    print("Last 10 search list \(self.arrRecentlySearched.removingDuplicates()) and count is \(self.arrRecentlySearched.count)")
                    self.userdefaults.set(self.arrRecentlySearched.removingDuplicates(), forKey: UserDefaultKeys.lastTenResult)
                    self.hideSpinner()
                    DispatchQueue.main.async {
                        if let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ImagesViewController") as? ImagesViewController {
                            destinationVC.searchKeyword = searchText
                            self.navigationController?.pushViewController(destinationVC, animated: true)
                        }
                    }
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

extension SearchViewController {
    func hideSpinner() {
        DispatchQueue.main.async {
            self.viewSpinner.isHidden = true
            self.tableView.isHidden = false
        }
    }
    
    func showSpinner() {
        DispatchQueue.main.async {
            self.viewSpinner.isHidden = false
            self.tableView.isHidden = true
        }
    }
}

