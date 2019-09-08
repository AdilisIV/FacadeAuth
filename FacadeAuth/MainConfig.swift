//
//  MainConfig.swift
//  FacadeAuth
//
//  Created by user on 13.08.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

final class MainConfig {
    
    static let apiBase = "http://ilyafedoroff.ru:3000/"
    static let supportEmail = "https://www.facebook.com/ilia.fyodoroff"

    struct Vkontakte {
        static let clientId = "7094931"
        static let scope = "email,offline,nohttps"
        static let redirect = "vk\(clientId)://authorize"
    }
    
    struct Facebook {
        static let clientId = "608700326334901"
        static let scope = "email"
        static let redirect = "fb\(clientId)://authorize"
    }
    
    struct Foursquare {
        static let clientId = "B35TTWPQ5VHHX5V0N41QLDERAV3K2GCDA3BV0WA1PMSUYSD5"
        static let clientSecret = "S0PR0C4JWE4CWXXJT2E0UAVUCCUCV1FSXQSNKI1U54KNTXHS"
        static let scope = "email"
        static let redirect = "foursquare\(clientId)://authorize"
    }
    
    struct Server {
        static var basicParams: [String: String] {
            var params = ["token": UserPrefencesEntity.shared.currentUser?.token ?? ""]
            #if DEBUG
                params["debug"] = "1"
            #endif
            return params
        }
    }
    
}
