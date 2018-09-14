//
//  SubCategoryTableViewController.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/13/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import UIKit

class SubCategoryTableViewController: UITableViewController {

    var subCat:Category!
    var subProduct:[String] = [String]()
    
    override func viewDidLoad() {
       // navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sub Category", style: .done, target: self, action: nil)
        super.viewDidLoad() 
        for i in 0..<subCat.products.count {
            let productname = subCat.products[i]["sub_category_name"] as! String
            self.subProduct.append(productname)
            //
        }
     
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subProduct.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let index = indexPath.row
        cell.textLabel?.text = subProduct[index]
        //cell.detailTextLabel?.text = subProduct[index]
        return cell
    }
    

    
    
    

}
