//
//  SecondParentCollectionViewCell.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/12/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import UIKit

class SecondParentCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondChildCollectionViewCell", for: indexPath) as! SecondChildCollectionViewCell
        let index = (indexPath as NSIndexPath).row
        //cell.imageView.sd_setImage(with:datasource[index], placeholderImage: UIImage())
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}
extension SecondParentCollectionViewCell :UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        return CGSize(width: screenSize.width, height: 200)
    }
    
    
}
