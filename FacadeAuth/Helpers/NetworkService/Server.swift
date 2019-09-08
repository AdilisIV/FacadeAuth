//
//  Server.swift
//  FacadeAuth
//
//  Created by user on 11.08.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case noConnection
    case failed(err: Error?)
    case invalidResponse
    
    var description: String {
        switch self {
        case .noConnection:
            return "Requst finished with NO_CONNECTION error"
        case .invalidResponse:
            return "Requst finished with EMPTY or WRONG response"
        case .failed(let error):
            return "Request failed with: \((error?.localizedDescription) ?? "wrong request")"
        }
    }
}

open class Server {
    
    let baseURL: String
    static let shared = Server(host: MainConfig.apiBase)
    private init(host: String) { self.baseURL = host }
    
    
    func request<T: PlainObject>(request: UniversalRequest<T>, completion: @escaping((T?, NetworkingError?) -> Void)) {
        loadRequest(request) { (jsonObj, error) in
            guard let jsonObj = jsonObj else {
                completion(nil, error)
                return
            }
            
            if let json = jsonObj as? JSONDictionary {
                let value = T(json: json)
                completion(value, nil)
            } else {
                completion(nil, .invalidResponse)
            }
        }
    }
    
    
    
    
    private func loadRequest<T>(_ request: UniversalRequest<T>, completion: @escaping((Any?, NetworkingError?) -> Void)) {
        guard let query = URL(string: baseURL + request.query) else {
            completion(nil, .failed(err: nil))
            return
        }
        
        var requestSession = URLRequest(url: query)
        var params = MainConfig.Server.basicParams
        
        if let reqParams = request.params {
            print(reqParams)
            params.merge(reqParams) { (_, new) in new }
        }
        
        let data = try? JSONSerialization.data(withJSONObject: params)
        requestSession.httpMethod = request.method.string
        requestSession.httpBody = data
        requestSession.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestSession.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let loadSession = URLSession.shared.dataTask(with: requestSession) { (data, _, error) in
            guard error == nil else {
                print("Session request finish with error: \(String(describing: error))")
                if !InternetChecker.check() {
                    OperationQueue.main.addOperation {
                        completion(nil, .noConnection)
                    }
                }
                return
            }
            
            guard let data = data else {
                OperationQueue.main.addOperation {
                    completion(nil, .invalidResponse)
                }
                return
            }
            
            let responseStr = String(data: data, encoding: .utf8) ?? ""
            print("Request: \(query.absoluteString)\n finish with response: \(responseStr)")
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
            OperationQueue.main.addOperation {
                completion(jsonObject, nil)
            }
        }
        
        loadSession.resume()
    }
    
    
}
