//
//  HomeViewCellType.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 12/09/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import Foundation
enum HomeRowType:String{
    case carousel = "carousel"
    case products = "products"
    case deals = "deals"
  
 
    static func allType() -> [HomeRowType]
    {
        let allItems:[HomeRowType] = [.carousel,.products,.deals]
        
        return allItems
    }
}
