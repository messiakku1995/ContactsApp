//
//  LoginModel.swift
//  ConnectsApp
//
//  Created by Utkarsh on 22/07/23.
//

import UIKit

// Login Request
struct LoginInRequest: Encodable {
    var email: String?
    var password: String?
}

struct loginData : Codable, CodableInit {
    let token: String?
    let error: String?
}

struct RegisterUserData: Codable, CodableInit {
    let id: Int?
    let token: String?
    let error: String?
}
