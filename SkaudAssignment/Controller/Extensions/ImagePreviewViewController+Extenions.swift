//
//  ImagePreviewViewController+Extenions.swift
//  SkaudAssignment
//
//  Created by Manish Sharma on 09/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UICollectionView data source
extension ImagePreviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.imagePreviewCell, for: indexPath) as? ImagePreviewCell else {
            fatalError("Cell not found")
        }
        
        let request = QueryRequestById(id: imageID!)
        imageResource.getImageById(request: request) { (response) in
            if response != nil {
                let getImageUrl = response?.hits![indexPath.row].previewURL
                cell.imgPreviewView.sd_setImage(with: URL(string: getImageUrl!), placeholderImage: UIImage(named: "placeholder.png"))
            }
        }
        return cell
    }
}

// MARK: - UICollectionView data flow layout delegate
extension ImagePreviewViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        let collectionHeight = collectionView.bounds.height
        return CGSize(width: collectionWidth, height: collectionHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}





