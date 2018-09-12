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

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    //var photoUrl:[URL] = [URL]()
    var rowType = HomeRowType.allType()
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
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
                            self.collectionView.reloadData()
                           
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
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1") as! TableViewCell1
//       // let index = (indexPath as NSIndexPath).row
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        guard let tableViewCell = cell as? TableViewCell1 else
//        { return
//        }
//        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
//    }
    
}

//MARK: CollectionView Protocols

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch rowType[indexPath.row]{
        case .carousel :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselParentCollectionViewCell", for: indexPath) as! CarouselParentCollectionViewCell
            cell.datasource = photoUrl
            return cell
        case .products:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselParentCollectionViewCell", for: indexPath) as! CarouselParentCollectionViewCell
            cell.datasource = photoUrl
            return cell
        case .deals:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselParentCollectionViewCell", for: indexPath) as! CarouselParentCollectionViewCell
            cell.datasource = photoUrl
            return cell
        case .dealDetails:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselParentCollectionViewCell", for: indexPath) as! CarouselParentCollectionViewCell
            cell.datasource = photoUrl
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return rowType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        switch rowType[indexPath.row]{
        case .carousel :
            return CGSize(width: screenSize.width, height: 200)
        case .products:
            return CGSize(width: screenSize.width, height: 200)
        case .deals:
            return CGSize(width: screenSize.width, height: 200)
        case .dealDetails:
            return CGSize(width: screenSize.width, height: 200)

        }
    }
    
    
}
