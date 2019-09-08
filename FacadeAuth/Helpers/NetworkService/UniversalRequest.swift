//
//  UniversalRequest.swift
//  FacadeAuth
//
//  Created by user on 21.08.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case get
    case post
    case delete
    
    var string: String {
        return self.rawValue.uppercased()
    }
}

struct UniversalRequest<T> {
    var query: String
    var params: [String: String]?
    var method: RequestMethod = .get
}


