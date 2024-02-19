//
//  APIConstants.swift
//  YogPath
//
//  Created by My Mac on 18/09/23.
//

import Foundation

enum Domain{
    case production
    case test
    
    var host:String{
        switch self{
        case .production:
            return "acharyaprashant.org/api/v2"
        case .test:
            return "acharyaprashant.org/api/v2"
        }
    }
}

class APIConstant {
    
    static let shared = APIConstant()
    
    var Domain:Domain = .production
    
    var host:String{
        return APIConstant.shared.Domain.host
    }
    
    var baseUrl:String {
        return "https://\(APIConstant.shared.host)/"//https://acharyaprashant.org/api/v2/legacy/books
    }
    
}

enum HTTPMeathod:String {
    case get = "GET"
    case post = "POST"
}

enum ApiType:String {
    case getBooksData = "legacy/books"
}
