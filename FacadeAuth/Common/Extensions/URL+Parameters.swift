//
//  URL+Parameters.swift
//  FacadeAuth
//
//  Created by user on 13.08.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import Foundation

extension URL {
    var parameters: [String: String]? {
        var params: [String: String] = [:]
        let components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        
        guard let fragment = components?.fragment else { return nil }
        
        let elements = fragment.components(separatedBy: "&")
        elements.forEach { (element) in
            let formant = element.components(separatedBy: "=")
            guard formant.count > 1 else { return }
            
            params[formant[0]] = formant[1]
        }
        
        return params
    }
}
