//
//  TableViewCell1.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/11/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import UIKit

class TableViewCell1: UITableViewCell {

    
   
    @IBOutlet weak var collectionView1: UICollectionView!
    
    //var image1 = UIImageView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCollectionViewDataSourceDelegate <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        //collectionView1.addSubview(image1)
        collectionView1.delegate = dataSourceDelegate
        collectionView1.dataSource = dataSourceDelegate
       // collectionView1.sd_imageURL() =
        collectionView1.tag = row
        collectionView1.reloadData()
    }
    
}
