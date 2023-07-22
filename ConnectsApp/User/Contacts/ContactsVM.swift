//
//  ContactsVM.swift
//  ConnectsApp
//
//  Created by Utkarsh on 22/07/23.
//

import UIKit

class ContactsVM {

    var repo: BaseRepository?
    var allUsers: AllUsers?
    var currentPage: Int = 0
    
    var reloadView: (() -> Void)?
    
    init(repo: BaseRepository) {
        self.repo = repo
        
        self.fetchUserData()
    }
    
    func fetchUserData() {
        self.currentPage = self.currentPage + 1
        self.getUserContactsData(request: "\(currentPage)") { data in
            guard let users = data else { return }
            
            if self.allUsers != nil, let newUsers = users.data {
                self.allUsers?.data?.append(contentsOf: newUsers)
            } else {
                self.allUsers = users
            }
            self.reloadView?()
        }
    }
    
    func getUserContactsData(request: String, success: @escaping (AllUsers?) -> Void){
        if currentPage > 1 {
            if currentPage > allUsers?.totalPages ?? 1 {
                return
            }
        }
        
        repo?.fetchAllUsers(showLoader: true, request: request) { users in
            success(users)
        } failure: { err in
            success(nil)
        }
    }
}
