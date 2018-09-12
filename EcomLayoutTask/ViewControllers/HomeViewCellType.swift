//
//  HomeViewCellType.swift
//  EcomLayoutTask
//
//  Created by Abhishek Singh on 12/09/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import Foundation
enum HomeRowType:String{
    case carousel = "carousel"
    case products = "products"
    case deals = "deals"
    case dealDetails = "deals_details"
 
    static func allType() -> [HomeRowType]
    {
        let allItems:[HomeRowType] = [.carousel,.products,.deals,.dealDetails]
        
        return allItems
    }
}
