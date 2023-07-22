//
//  UserModel.swift
//  ConnectsApp
//
//  Created by Utkarsh on 22/07/23.
//

import UIKit

// MARK: - Welcome
struct AllUsers: Codable, CodableInit {
    let page, perPage, total, totalPages: Int?
    var data: [UserContact]?
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Datum
struct UserContact: Codable, CodableInit {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable, CodableInit {
    let url: String
    let text: String
}
