//
//  CategoryCollectionViewController.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/13/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"

class CategoryCollectionViewController: UICollectionViewController {
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let tableSegue = "SubCategoryTableViewController"
    var categoryArray:[Category] = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        getCategoryData()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let space:CGFloat = 2.0
        let dimension = (view.frame.size.width - (3 * space)) / 3.0
        let height1 = (dimension * 4) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: height1)
    }

    func getCategoryData()
    {
       
        let parameters = ["result":["timestamp":""]] as [String:AnyObject]
        Alamofire.request(APIRouter.secondApi(params: parameters )).responseJSON { (responseData) -> Void in
            if let response = (responseData.result.value)  {
                
                if let swiftyJsonVar = JSON(response).dictionaryObject {
                    guard let result = swiftyJsonVar["ecommerce"] as? [String:AnyObject] else {
                        return
                    }
                    guard let category = result["category"] as? [[String:AnyObject]] else {
                        return
                    }
                    self.categoryArray = Category.dataForCategory(category)
                    performUIUpdatesOnMain {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.collectionView?.reloadData()
                        
                    }
                }
            }
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categoryArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        let index = indexPath.row
        let singleCategory = categoryArray[index]
        if let imageURL = URL(string: (singleCategory.icon)) {
            cell.imageView.sd_setImage(with: imageURL, placeholderImage: UIImage())
        }
        cell.name.text = singleCategory.name
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: tableSegue) as! SubCategoryTableViewController
        detailController.subCat = self.categoryArray[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
  /*
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        
            let screenWidth = screenSize.width
            let cellGridSize: CGFloat = (screenWidth/2.0) - 5
            // let cellHeight: CGFloat = (cellGridSize*3)/2
            return CGSize(width: cellGridSize, height: cellGridSize)
        
    }
    */

}

