//
//  LoginVM.swift
//  ConnectsApp
//
//  Created by Utkarsh on 22/07/23.
//

import UIKit
import Alamofire

class LoginVM {
    
    var repo = BaseRepository()
    init() {}
    
    func login(loginRequest: LoginInRequest, success: @escaping (loginData?) -> Void){
        repo.login(showLoader: true, request: loginRequest) { userInfo in
            success(userInfo)
        } failure: { err in
            success(nil)
        }
    }
    
    func register(loginRequest: LoginInRequest, success: @escaping (RegisterUserData?) -> Void){
        repo.register(showLoader: true, request: loginRequest) { userInfo in
            success(userInfo)
        } failure: { err in
            success(nil)
        }
    }
}
