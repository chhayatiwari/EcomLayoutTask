//
//  DealChildCollectionViewCell.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/12/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import UIKit
import SDWebImage

class DealChildCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    
  /*  var dealArray : Deal!  {
        didSet{
            if let imageURL = URL(string: (dealArray.image)) {
                imageView.sd_setImage(with:imageURL, placeholderImage: UIImage())
            }
            productName.text = dealArray.name
            price.text = "₹ \(dealArray.price)"
            
        }
    } */
}
