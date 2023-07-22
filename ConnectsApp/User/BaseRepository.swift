//
//  BaseRepository.swift
//  ConnectsApp
//
//  Created by Utkarsh on 22/07/23.
//

import Foundation
import Alamofire

enum ErrorMessage : Int,LocalizedError,Codable {
    case Success = 200
}

protocol BaseRepositoryProtocol{
    func login(showLoader: Bool,
               request: LoginInRequest,
               completion:@escaping (loginData)-> Void,
               failure: @escaping (Error) -> Void)
}

extension BaseRepositoryProtocol {
    
    func login(showLoader: Bool,
               request: LoginInRequest,
               completion:@escaping (loginData)-> Void,
               failure: @escaping (Error) -> Void){
        ApiRouter.login(request: request).send(showLoader, loginData.self) { (result) in
            
            switch result {
            case .success(let response) :
                completion(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func register(showLoader: Bool,
               request: LoginInRequest,
               completion:@escaping (RegisterUserData)-> Void,
               failure: @escaping (Error) -> Void){
        ApiRouter.register(request: request).send(showLoader, RegisterUserData.self) { (result) in
            
            switch result {
            case .success(let response) :
                completion(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func fetchAllUsers(showLoader: Bool,
                               request: String,
                               completion:@escaping (AllUsers)-> Void,
                               failure: @escaping (Error) -> Void){
        ApiRouter.fetchAllUsers(request: request).send(showLoader, AllUsers.self) { (result) in
            switch result {
            case .success(let response) :
                completion(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

class BaseRepository: BaseRepositoryProtocol{
    
}


public protocol CodableInit {
    init(data: Data) throws
}

public typealias CodableInitWithDecodable = Decodable & CodableInit

public extension CodableInit where Self: Codable {
    init(data: Data) throws {
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}
