//
//  LoginProcessController.swift
//  FacadeAuth
//
//  Created by user on 24.07.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import Foundation

class LoginProcessController {
    
    static func setupCurrentUser(user: UserPlainObject) {
        UserPrefencesEntity.shared.isLoggedIn = true
        
        var currentUser: UserPlainObject
        if UserPrefencesEntity.shared.currentUser == nil {
            currentUser = UserPlainObject()
        } else {
            currentUser = UserPrefencesEntity.shared.currentUser!
        }
        
        // change user
        currentUser.id = user.id
        currentUser.name = user.name
        currentUser.lastname = user.lastname
        currentUser.photoUrl = user.photoUrl ?? ""
        currentUser.token = user.token
        currentUser.email = user.email ?? ""
        currentUser.phone = user.phone
        currentUser.status = user.status
        
        UserPrefencesEntity.shared.updateUser(user: currentUser)
    }
    
    static var isLogin: Bool {
        return UserPrefencesEntity.shared.isLoggedIn
    }
    
    static func logout() {
        UserPrefencesEntity.shared.isLoggedIn = false
        UserPrefencesEntity.shared.updateUser(user: nil)
    }
    
}
