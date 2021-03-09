//
//  ImagesViewController.swift
//  SkaudAssignment
//
//  Created by Manish Sharma on 08/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import Foundation
import  UIKit
import SDWebImage

// MARK: - UICollectionView data source
extension ImagesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrImageList.count > 0 {
            return arrImageList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.imageCell, for: indexPath) as? ImageCell else {
            fatalError("Cell not found")
        }
    
        let url = URL(string: arrImageList[indexPath.row].previewURL!)!
        cell.imgView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        cell.layoutIfNeeded()
        return cell
    }

}

// MARK: - UICollectionView delegate
extension ImagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: Identifiers.imagePreviewVCId) as? ImagePreviewViewController {
            destinationVC.imageID = arrImageList[indexPath.row].id!
            destinationVC.arrImages = arrImageList
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
        print("Click at indexpath \(indexPath.row)")
    }
}

// MARK: - UICollectionView data flow layout delegate
extension ImagesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth/3 - 2, height: collectionWidth/3 - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ActivityCell", for: indexPath) as! ActivityLoaderCV
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if arrImageList.count > 0 {
            if elementKind == UICollectionView.elementKindSectionFooter {
                self.loadingView?.activityIndicator.startAnimating()
                self.loadingView?.isHidden = false
            }
        } else {
            self.loadingView?.isHidden = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == arrImageList.count - 1 && !self.isLoading {
            loadMoreData()
        }
    }
}

