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
    var arrImageList = [Hit]()
    var isLoading = false
    var loadingView: ActivityLoaderCV?
    var pageIndex = 1
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // condition is already checked in parent view controller about empty
        self.navigationItem.title = searchKeyword
        let loadingReusableNib = UINib(nibName: "ActivityLoaderCV", bundle: nil)
        collectonView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "ActivityCell")
        
        collectonView.alwaysBounceVertical = true
        getImagesByKeyword(page: 1)
    }
    
    // MARK: API Call
    func getImagesByKeyword(page: Int) {
        let queryRequest = QueryRequest(q: searchKeyword)
        imageResources.getImagesWithPages(request: queryRequest, keyword: searchKeyword!, page: pageIndex) { (response) in
            if response!.total! > 0 {
                for index in 0..<(response?.hits)!.count {
                    self.arrImageList.append((response?.hits![index])!)
                }
                DispatchQueue.main.async {
                    self.collectonView.reloadData()
                }
            }
            self.isLoading = false
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                // Fake background loading task for 2 seconds
                sleep(2)
                // Download more data here
                self.pageIndex += 1
                self.getImagesByKeyword(page: self.pageIndex)

                DispatchQueue.main.async {
                    self.collectonView.reloadData()
                }
            }
        }
    }

}

