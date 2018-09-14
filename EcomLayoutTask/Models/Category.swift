//
//  category.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/13/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import Foundation
struct Category {
    
    // MARK: Properties
    
    let name: String
    let icon: String
    let products: [[String:AnyObject]]
    
    // MARK: Initializers
    
    init(dictionary: [String:AnyObject]) {
        name = dictionary["category_name"] as! String
        icon = dictionary["app_icon"] as! String
        products = dictionary["sub_category"] as! [[String:AnyObject]]
    }
    
    static func dataForCategory(_ results: [[String:AnyObject]]) -> [Category] {
        
        var current = [Category]()
        
        // iterate through array of dictionaries, each offer is a dictionary
        for result in results {
            current.append(Category(dictionary: result))
        }
        
        return current
    }
    
}
