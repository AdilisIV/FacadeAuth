//
//  VKResource.swift
//  FacadeAuth
//
//  Created by user on 24.07.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import Foundation

final class VKResource: SocialResource {

    fileprivate var token: String?
    fileprivate var secret: String?
    var appScheme = URL(string: "vk://")
    
    
    var authURL: URL? {
        var authString: String
        if isAppExist {
            authString = "vkauthorize://authorize?sdk_version=1.4.6&client_id=\(MainConfig.Vkontakte.clientId)"
            authString += "&scope=\(MainConfig.Vkontakte.scope)&revoke=1&v=5.40"
        } else {
            authString = "https://oauth.vk.com/authorize?revoke=1&response_type=token&display=mobile"
            authString += "&scope=\(MainConfig.Vkontakte.scope)&v=5.40&redirect_uri=\(MainConfig.Vkontakte.redirect)"
            authString += "&sdk_version=1.4.6&client_id=\(MainConfig.Vkontakte.clientId)"
        }
        return URL(string: authString)
    }
    
    func parameters(from url: URL) -> [String: String] {
        let parameters = url.parameters
        guard
            let token = parameters?["access_token"],
            let secret = parameters?["secret"],
            let email = parameters?["email"]
            else { return [:] }
        return ["token": token, "secret": secret, "email": email]
    }
    
    
}
