//
//  FBResource.swift
//  FacadeAuth
//
//  Created by user on 24.07.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import Foundation

final class FBResource: SocialResource {
    
    fileprivate var token: String?
    fileprivate var secret: String?
    var appScheme = URL(string: "fb://")
    
    
    var authURL: URL? {
        var authString = "https://www.facebook.com/v2.8/dialog/oauth?client_id=\(MainConfig.Facebook.clientId)"
        authString += "&redirect_uri=\(MainConfig.Facebook.redirect)&scope=\(MainConfig.Facebook.scope)"
        return URL(string: authString)
    }
    
    func parameters(from url: URL) -> [String: String] {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if let code = components?.queryItems?.first?.value {
            return ["token": code, "secret": "", "redirect_uri": "\(MainConfig.Facebook.redirect)", "email": ""]
        }
        return [:]
    }
}
