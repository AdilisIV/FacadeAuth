//
//  UserPrefencesEntity.swift
//  FacadeAuth
//
//  Created by user on 24.07.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import Foundation

class UserPrefencesEntity {
    static let shared = UserPrefencesEntity()
    private init() {}
    
    private(set) var currentUser: UserPlainObject?
    var isLoggedIn: Bool = false
    var pushToken: String = ""
    
    
    func updateUser(user: UserPlainObject?) {
        self.currentUser = user
        // registerNotification this
    }
}
