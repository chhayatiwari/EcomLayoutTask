//
//  CarouselParentCollectionViewCell.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 12/09/18.
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
        startTimer()
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
    
    @objc func autoScroll() {
        if let coll  = collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  <  datasource.count )
                {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                
            }
        }
    }
    
    func startTimer() {
        
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("autoScroll"), userInfo: nil, repeats: true)
    }
}
