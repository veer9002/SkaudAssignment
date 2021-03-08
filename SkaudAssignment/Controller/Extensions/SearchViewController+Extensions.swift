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
//        if let lastTenSearchedKeywords = userdefaults.object(forKey: UserDefaultKeys.lastTenResult) as? [String] {
//            return lastTenSearchedKeywords.count
//        }
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
        
    }
}
