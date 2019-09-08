//
//  TwitterResource.swift
//  FacadeAuth
//
//  Created by user on 24.07.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import Foundation

final class FoursquareResource: SocialResource {
    
    fileprivate var token: String?
    fileprivate var secret: String?
    var appScheme = URL(string: "foursquare://")
    
    
    var authURL: URL? {
        var authString = "https://foursquare.com/oauth2/authenticate?client_id=\(MainConfig.Foursquare.clientId)&response_type=code"
        authString += "&redirect_uri=\(MainConfig.Foursquare.redirect)"
        return URL(string: authString)
    }
    
    func parameters(from url: URL) -> [String : String] {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if let code = components?.queryItems?.first?.value {
            return ["token": code, "secret": ""]
        }
        return [:]
    }
}
