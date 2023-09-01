//
//  Endpoint.swift
//  Meals
//
//  Created by Beyza Sude Erol on 31.08.2023.
//

import Foundation

protocol EndpointProtocol{
    var baseUrl: String {get}
    var path : String {get}
    var method : HttpMethod {get}
    var header : [String : String]? {get}
    func request () -> URLRequest
}

enum HttpMethod : String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum EndPoint{
    case search
    case detail
}

extension EndPoint : EndpointProtocol{
    var baseUrl: String {
        return "https://www.themealdb.com"
    }
    
    var path: String {
        switch self {
        case .search :
            return "/json/v1/1/search.php?s="
        case .detail :
            return "/api/json/v1/1/lookup.php?i="
            
        }
    }
    
    var method: HttpMethod {
        switch self{
        case .search :
            return .post
        case .detail :
            return .post
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    func request() -> URLRequest {
        guard var component = URLComponents(string: baseUrl) else{
            fatalError("Invalid Error")
        }
        component.path = path
        var request = URLRequest(url: component.url!)
        request.httpMethod =  method.rawValue
        return request
    }
}
