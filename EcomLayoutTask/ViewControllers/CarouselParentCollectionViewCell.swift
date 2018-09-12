//
//  CarouselParentCollectionViewCell.swift
//  EcomLayoutTask
//
//  Created by Abhishek Singh on 12/09/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import UIKit

class CarouselParentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!

    
    var datasource : [URL]!{
        didSet{
            self.collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

extension CarouselParentCollectionViewCell : UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselChildCollectionViewCell", for: indexPath) as! CarouselChildCollectionViewCell
        let index = (indexPath as NSIndexPath).row
        cell.imageView.sd_setImage(with:datasource[index], placeholderImage: UIImage())
        return cell
        }
}


extension CarouselParentCollectionViewCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let screenSize: CGRect = UIScreen.main.bounds
        return CGSize(width: screenSize.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
    }
}
