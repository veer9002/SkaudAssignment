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
    @IBOutlet weak var collectonView: UICollectionView!
    var searchKeyword: String?
    let imageResources: ImageResources = ImageResources()
    var arrImageList = [ImageResponse]()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // condition is already checked in parent view controller about empty
        self.navigationItem.title = searchKeyword
        getImagesByKeyword(page: 1)
    }
    
    // MARK: API Call
    func getImagesByKeyword(page: Int) {
        let queryRequest = QueryRequest(q: searchKeyword)
        imageResources.getImagesWithPages(request: queryRequest, keyword: searchKeyword!, page: 1) { (response) in
            self.arrImageList.append(response!)
            DispatchQueue.main.async {
                self.collectonView.reloadData()
            }
            print(self.arrImageList.count)
        }
    }

}

