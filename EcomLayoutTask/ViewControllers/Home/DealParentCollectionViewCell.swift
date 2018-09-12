//
//  DealParentCollectionViewCell.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/12/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import UIKit

class DealParentCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var dealArray:[Deal] = [Deal]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dealArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DealChildCollectionViewCell", for: indexPath) as! DealChildCollectionViewCell
        let index = (indexPath as NSIndexPath).row
        let product = dealArray[index]
        
        if let imageURL = URL(string: product.image) {
            cell.imageView.sd_setImage(with:imageURL, placeholderImage: UIImage())
        }
        //
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}

extension DealParentCollectionViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        return CGSize(width: (screenSize.width/2)-5, height: 100)
    }
    
    
}
