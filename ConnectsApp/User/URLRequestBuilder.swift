//
//  URLRequestBuilder.swift
//  ConnectsApp
//
//  Created by Utkarsh on 22/07/23.
//


import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible,APIRequestHandler {
    
    var mainURL: URL { get }
    var requestURL: URL { get }
    // MARK: - Path
    var path: ServerPaths { get }
    
    var headers: HTTPHeaders { get }
    // MARK: - Parameters
    var parameters: Parameters? { get }
    
    // MARK: - Methods
    var method: HTTPMethod { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
    
    var deviceId: String { get }
}
extension URLRequestBuilder {
    
    //URL(string: "http://americana.appskeeper.com/")!
    var mainURL: URL {
        return URL(string:"https://reqres.in/")!
    }
    var requestURL: URL {
        return mainURL.appendingPathComponent(path.rawValue)
    }
    var headers: HTTPHeaders {
        var header = HTTPHeaders()
//        if let token = KeyChain.userToken {
//            header["Authorization"] = "Bearer \(token)"
//        }
        return header
    }
    
    var defaultParams: Parameters {
        var param = Parameters()
        param["deviceId"] = deviceId
        return param
    }
    
    var encoding: ParameterEncoding {
        
        switch method {
            
        case .get:
            return URLEncoding.default
            
        case .delete:
            return URLEncoding.default

        default:
            return JSONEncoding.default
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.name) }
        return request
    }
    
    var deviceId: String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    var parameters: Parameters{
        return Parameters()
    }
}
enum ServerPaths: String {
    case login = "api/login"
    case register = "api/register"
    case fetchAllUsers = "api/users"
}
