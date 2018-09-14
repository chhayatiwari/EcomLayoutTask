//
//  APIRouter.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/10/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter:URLRequestConvertible {
    
    case dashboardApi(params:Parameters)
    case getCategoryApi(params:Parameters)
    
    var method:HTTPMethod {
        switch self {
        case .dashboardApi:
            return .get
        case .getCategoryApi:
            return .post
        }
    }
    
    static let baseUrlString = "https://mrnmrsekart.com/api"
    
    var path:String{
        switch self{
        case .dashboardApi:
            return "/Dashboard"
        case .getCategoryApi:
            return "/GetCategory"
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseUrlString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        switch self {
        case .dashboardApi(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .getCategoryApi(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
