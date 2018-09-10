//
//  HomeViewController.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/10/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var photoUrl:[URL] = [URL]()
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
                                    self.photoUrl.append(imageURL)
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
                    guard let offer = result["offer"] as? [[String:AnyObject]] else {
                        return
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photoUrl.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}

