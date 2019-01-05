
//
//  ApiRouter.swift
//  Upraxis-Exam
//
//  Created by Al John Albuera on 05/01/2019.
//  Copyright © 2019 Al John Albuera. All rights reserved.
//

import UIKit
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    case getUserList([String:Any])
    
    var baseURL: String {
        return "http://www.json-generator.com/api/json/"
    }
    
    static var coinId: String?
    
    
    var path: String {
        switch self {
        case .getUserList:
            return "get/cqSEcFaqaa"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUserList:
            return .get
            
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let URL = try baseURL.asURL()
        
        var urlRequest = URLRequest(url: URL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getUserList(let userListData):
            return try URLEncoding.default.encode(urlRequest, with: userListData)
        default:
            return urlRequest
        }
    }
    
    
    static func getUserInfoList(userList: [String: Any],
                                          _ completion: @escaping (_ results: AnyObject?, _ error: NSError?) -> Void){
        
        Alamofire.request(ApiRouter.getUserList(userList as [String : AnyObject]))
            .responseJSON{
                response in
                switch response.result {
                case let .success(results):
                    return completion(results as AnyObject?, nil)
                case let .failure(err):
                    return completion(nil, err as NSError?)
                }
                
        }
        
    }
    
}
