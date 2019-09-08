//
//  SocialResource.swift
//  FacadeAuth
//
//  Created by user on 24.07.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import UIKit

protocol SocialResource {
    var authURL: URL? {get}
    var appScheme: URL? {get}
    var isAppExist: Bool {get}
    
    func parameters(from url: URL) -> [String: String]
}

extension SocialResource {
    var isAppExist: Bool {
        guard let scheme = self.appScheme else {return false}
        return UIApplication.shared.canOpenURL(scheme)
    }
}
