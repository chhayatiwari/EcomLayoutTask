//
//  HomeTableViewController.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/10/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

var photoUrl:[URL] = [URL]()
var dealItem:[Deal] = [Deal]()
var offerItem:[Offer] = [Offer]()

class HomeTableViewController: UITableViewController {
    
    //var photoUrl:[URL] = [URL]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func callAPI() {
        let Parameters = ["":""]
        Alamofire.request(APIRouter.firstApi(params: Parameters )).responseJSON { (responseData) -> Void in
            if let response = (responseData.result.value)  {
                
                if let swiftyJsonVar = JSON(response).dictionaryObject {
                    guard let result = swiftyJsonVar["ecommerce"] as? [String:AnyObject] else {
                        return
                    }
                    guard let banner = result["banner"] as? [[String:AnyObject]] else {
                        return
                    }
                    if banner.count == 0 {
                       // self.showAlert("No such photos in \(banner)")
                    } else {
                        for photo in banner {
                            if let photoStr = photo["banner_image"] as? String {
                                if let imageURL = URL(string: photoStr) {
                                    photoUrl.append(imageURL)
                                }
                                else {
                                  //  self.showAlert("Image does not exist")
                                }
                            }
                        }
                        performUIUpdatesOnMain {
                            self.tableView.reloadData()
                           
                        }
                    }
                    guard let deal = result["DOD"] as? [[String:AnyObject]] else {
                        return
                    }
                    dealItem = Deal.dataForDeal(deal)
                    guard let offer = result["offer"] as? [[String:AnyObject]] else {
                        return
                    }
                    offerItem = Offer.dataForOffer(offer)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! TableViewCell1
       // let index = (indexPath as NSIndexPath).row
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? TableViewCell1 else
        { return
        }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
}

//MARK: CollectionView Protocols

extension HomeTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell1
        let index = (indexPath as NSIndexPath).row
        //cell.image1.sd_setImage(with:photoUrl[index], placeholderImage: UIImage())
        //cell.image = photoUrl[indexPath.item]
       // cell.sd_imageURL() = photoUrl[indexPath.item]
        cell.imageView.sd_setImage(with:photoUrl[index], placeholderImage: UIImage())
       
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        
        return photoUrl.count
    }
    
    
}
