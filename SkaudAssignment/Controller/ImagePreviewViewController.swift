//
//  ImagePreviewViewController.swift
//  SkaudAssignment
//
//  Created by Manish Sharma on 08/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import UIKit
import SDWebImage

class ImagePreviewViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    let imageResource: ImageResources = ImageResources()
    var imageID: Int?
    var arrImages: [Hit] = [Hit]()
    var contentOffset: CGFloat = 0
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}

