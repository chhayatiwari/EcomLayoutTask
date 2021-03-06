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
import SystemConfiguration


class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var photoUrl:[URL] = [URL]()
    var dealItem:[Deal] = [Deal]()
    var offerItem:[Offer] = [Offer]()
    var rowType = HomeRowType.allType()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        getDashboardData()
    }
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    func showAlert(_ msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func getDashboardData()
    {
        guard isInternetAvailable() else {
            showAlert("No Internet Connection")
            return
        }
        let Parameters = ["":""]
        Alamofire.request(APIRouter.dashboardApi(params: Parameters )).responseJSON { (responseData) -> Void in
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
                                    self.photoUrl.append(imageURL)
                                }
                                else {
                                  //  self.showAlert("Image does not exist")
                                }
                            }
                        }
                        
                    }
                    guard let deal = result["DOD"] as? [[String:AnyObject]] else {
                        return
                    }
                    self.dealItem = Deal.dataForDeal(deal)
                    
                    guard let offer = result["offer"] as? [[String:AnyObject]] else {
                        return
                    }
                    self.offerItem = Offer.dataForOffer(offer)
                    performUIUpdatesOnMain {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.collectionView.reloadData()
                        
                    }
                }
            }
        }
    }

    
}

//MARK: CollectionView Protocols

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < 3{
            switch rowType[indexPath.row] {
            case .carousel :
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselParentCollectionViewCell", for: indexPath) as! CarouselParentCollectionViewCell
                cell.datasource = photoUrl
                return cell
            case .products:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondParentCollectionViewCell", for: indexPath) as! SecondParentCollectionViewCell
                cell.datasource = photoUrl
                return cell
            case .deal:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewCollectionViewCell", for: indexPath)
                return cell
            }
        }
       
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DealChildCollectionViewCell", for: indexPath) as! DealChildCollectionViewCell
                    let deal = self.dealItem[((indexPath as NSIndexPath).row)-3]
                        cell.productName.text = deal.name
                        cell.price.text = "₹ \(deal.price)"
                        if let imageURL = URL(string: (deal.image)) {
                        cell.imageView.sd_setImage(with: imageURL, placeholderImage: UIImage())
                    }
            
                return cell
            }
        }
    
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return rowType.count + dealItem.count
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        if indexPath.row <= 2
        {
            switch rowType[indexPath.row]{
            case .carousel :
                return CGSize(width: screenSize.width, height: 200)
            case .products:
                return CGSize(width: screenSize.width, height: 80)
            case .deal:
                return CGSize(width: screenSize.width, height: 50)
            }
        }
        
        else{
            let screenWidth = screenSize.width
            let cellGridSize: CGFloat = (screenWidth / 2.0) - 5
            // let cellHeight: CGFloat = (cellGridSize*3)/2
            return CGSize(width: cellGridSize, height: cellGridSize)
        }
    }
    
    
}
