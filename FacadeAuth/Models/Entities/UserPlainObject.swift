//
//  UserPlainObject.swift
//  FacadeAuth
//
//  Created by user on 24.07.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]


final class UserPlainObject: PlainObject {
    var id: String = "0"
    var token: String = ""
    var social: String?
    var name: String?
    var status: String?
    var lastname: String?
    var photoUrl: String?
    var phone: String?
    var email: String?
}

extension UserPlainObject {
    convenience init?(json: JSONDictionary) {
        self.init()
        guard let token = json["token"] as? String, let id = json["id"] as? String else { return nil }
        self.token = token
        self.id = id
        self.social = json["social"] as? String
        self.name = json["name"] as? String
        self.status = json["status"] as? String
        self.lastname = json["lastname"] as? String
        self.photoUrl = json["photoUrl"] as? String
        self.phone = json["phone"] as? String
        self.email = json["email"] as? String
    }
}

extension UserPlainObject {
    struct Request {
        static func auth(token: String, secret: String, social: String, email: String, redirect_uri: String) -> UniversalRequest<UserPlainObject> {
            let params =  ["token": token, "secret": secret, "social": social, "email": email, "redirect_uri": redirect_uri]
            return UniversalRequest<UserPlainObject>(query: "users/auth/", params: params, method: .post)
        }
    }
}
