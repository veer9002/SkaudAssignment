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
            return arrImageList[0].hits!.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.imageCell, for: indexPath) as? ImageCell else {
            fatalError("Cell not found")
        }
    
        let url = URL(string: arrImageList[0].hits![indexPath.row].previewURL!)!
        cell.imgView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        cell.layoutIfNeeded()
        return cell
    }

}

// MARK: - UICollectionView delegate
extension ImagesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
}





