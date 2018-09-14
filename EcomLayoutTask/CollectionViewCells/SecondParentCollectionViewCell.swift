//
//  SecondParentCollectionViewCell.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/12/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import UIKit

class SecondParentCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var logo = [UIImage(named: "book"), UIImage(named: "grocery"), UIImage(named: "health"), UIImage(named: "home2"), UIImage(named: "apperel")]
    var text = ["Book", "Grocery", "Health", "Household", "Apperel"]
    var datasource : [URL]!{
        didSet{
            if datasource.count > 0{
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return text.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondChildCollectionViewCell", for: indexPath) as! SecondChildCollectionViewCell
        
        let index = indexPath.row
            cell.imageView.image = logo[index]
            cell.name.text = text[index]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}
extension SecondParentCollectionViewCell :UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        return CGSize(width: 80, height: 80)
    }
    
    
}
