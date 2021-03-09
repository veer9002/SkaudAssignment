//
//  Encodable+Extensions.swift
//  SkaudAssignment
//
//  Created by Manish Sharma on 07/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UITableView data source
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRecentlySearched.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = arrRecentlySearched[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableView delegates
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToImage(with: arrRecentlySearched[indexPath.row])
    }
}


// MARK: - Custom methods
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
    
    func navigateToImage(with keyword: String) {
        DispatchQueue.main.async {
            if let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: Identifiers.imagesVCId) as? ImagesViewController {
                destinationVC.searchKeyword = keyword
                self.navigationController?.pushViewController(destinationVC, animated: true)
            }
        }
    }
}

