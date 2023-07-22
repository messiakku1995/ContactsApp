//
//  ApiRouter.swift
//  ConnectsApp
//
//  Created by Utkarsh on 22/07/23.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestBuilder {
    
    case login(request: LoginInRequest)
    case register(request: LoginInRequest)
    case fetchAllUsers(request: String)
    
    
    // MARK: - Path
    internal var path: ServerPaths {
        
        switch self {
        case .login:
            return .login
        case .register:
            return .register
        case .fetchAllUsers:
            return .fetchAllUsers
        }
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = Parameters()
        
        switch self {
        case .login(let request):
            params["email"] = request.email
            params["password"] = request.password
        case .register(let request):
            params["email"] = request.email
            params["password"] = request.password
        case .fetchAllUsers(let request):
            params["page"] = request
        }
        
        return params
    }
    
    // MARK: - Methods
    internal var method: HTTPMethod {
        
        switch self{
        case .fetchAllUsers(_) : return .get
            
        case .login(_): return .post
            
        default: return .post
            
        }
    }
    
    internal var headers: HTTPHeaders {
        
        var header = HTTPHeaders()
        let accessToken = UserDefaults.standard.value(forKey: "token") as? String ?? ""
        
        header["Authorization"] = "Bearer \(accessToken)"
        print("header:::\(header)")
        return header
    }
}

public extension Encodable {
    /**
     To parse json data to a dictionary
     - returns: [String: Any]
     */
    func asDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    
    /**
     To encode a model to encoded Data format
     - returns: Data
     */
    func asData() throws -> Data {
        let data = try JSONEncoder().encode(self)
        return data
    }
}

