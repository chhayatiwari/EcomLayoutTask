//
//  Offer.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/11/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import Foundation
struct Offer {
    
    // MARK: Properties
    
    let id: String
    let products: [String:AnyObject]
    
    // MARK: Initializers
    
    init(dictionary: [String:AnyObject]) {
        id = (dictionary["id"] as! String)
        products = (dictionary["products"] as! [String:AnyObject])
    }
    
    static func dataForOffer(_ results: [[String:AnyObject]]) -> [Offer] {
        
        var current = [Offer]()
        
        // iterate through array of dictionaries, each offer is a dictionary
        for result in results {
            current.append(Offer(dictionary: result))
        }
        
        return current
    }
    
}
