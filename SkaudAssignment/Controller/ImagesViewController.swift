//
//  ImagesViewController.swift
//  SkaudAssignment
//
//  Created by Manish Sharma on 07/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var collectonViewController: UICollectionView!
    var searchKeyword: String?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // condition is already checked in parent view controller about empty
        print(searchKeyword!)
    }

}

//extension ImagesViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//}

extension ImagesViewController: UICollectionViewDelegate {
    
}

extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    
}

