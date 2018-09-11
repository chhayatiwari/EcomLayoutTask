//
//  Deal.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/11/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import Foundation
struct Deal {
    
    // MARK: Properties
    
    let id: String
    let image: String
    
    // MARK: Initializers
    
    init(dictionary: [String:AnyObject]) {
        id = (dictionary["product_id"] as! String)
        image = (dictionary["product_image"] as! String)
    }
    
    static func dataForDeal(_ results: [[String:AnyObject]]) -> [Deal] {
        
        var current = [Deal]()
        
        // iterate through array of dictionaries, each deal is a dictionary
        for result in results {
            current.append(Deal(dictionary: result))
        }
        
        return current
    }
    
}
