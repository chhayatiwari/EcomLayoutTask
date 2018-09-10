//
//  APIRouter.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/10/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter:URLRequestConvertible{
    case firstApi(params:Parameters)
    case secondApi(params:Parameters)
    
    var method:HTTPMethod{
        switch self{
        case .firstApi:
            return .get
        case .secondApi:
            return .post
        }
    }
    
    static let baseUrlString = "https://mrnmrsekart.com/api/Dashboard"
    
    var path:String{
        switch self{
        case .firstApi:
            return ""
        case .secondApi:
            return ""
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseUrlString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        switch self {
        case .firstApi(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .secondApi(let parameters):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
