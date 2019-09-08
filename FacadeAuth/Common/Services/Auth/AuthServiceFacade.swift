//
//  AuthServiceFacade.swift
//  FacadeAuth
//
//  Created by user on 24.07.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import UIKit
import SafariServices

final class AuthServiceFacade {
    
    fileprivate var safariController: SFSafariViewController?
    fileprivate weak var currentController: UIViewController?
    fileprivate var currentService: AuthResourceType?
    fileprivate var loginCompletion: ((UserPlainObject?, Error?) -> Void)?
    
    enum AuthResourceType: String {
        case vk
        case fb
        case foursquare
        
        var identifier: String {
            return self.rawValue
        }
        
        var socialResource: SocialResource {
            switch self {
            case .vk:
                return VKResource()
            case .fb:
                return FBResource()
            case .foursquare:
                return FoursquareResource()
            }
        }
    }
    
    
    init() {
        print("init")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AuthServiceFacade.loggedInHandler(_:)),
                                               name: Notification.Name.CloseSafariNotification,
                                               object: nil)
    }
    
    
    func login(with service: AuthResourceType, from view: UIViewController, completion: @escaping(UserPlainObject?, Error?) -> Void) {
        self.loginCompletion = completion
        self.currentController = view
        self.currentService = service
        
        let isLoggedIn = LoginProcessController.isLogin
        if isLoggedIn {
            completion(nil, nil)
        } else {
            guard let authURL = service.socialResource.authURL else {
                assertionFailure("Auth url error")
                return
            }
            if service.socialResource.isAppExist {
                UIApplication.shared.open(authURL)
            } else {
                openSafariController(with: authURL)
            }
        }
    }
    
    @objc func loggedInHandler(_ notification: Notification? = nil) {
        self.closeSafariController()
        
        guard let notification = notification,
            let url = notification.object as? URL else { return }
        
        let params = currentService?.socialResource.parameters(from: url)
        guard let token = params?["token"],
            let secret = params?["secret"],
            let email = params?["email"],
            let redirect_uri = params?["redirect_uri"],
            let socialID = currentService?.identifier
        else { return }
        
        ActivityIndicator.shared.showProgressView(view: currentController?.view)
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // register user on your server
        // and get newAccount data
        let authRequest = UserPlainObject.Request.auth(token: token, secret: secret, social: socialID, email: email, redirect_uri: redirect_uri)
        Server.shared.request(request: authRequest) { (user, error) in
            UIApplication.shared.endIgnoringInteractionEvents()
            ActivityIndicator.shared.hideProgressView()
            
            guard let loginCompletion = self.loginCompletion else { return }
            if error == nil {
                loginCompletion(user, nil)
            } else {
                loginCompletion(nil, error)
            }
        }
    }
    
}


extension AuthServiceFacade {
    
    fileprivate func openSafariController(with URL: URL) {
        safariController = SFSafariViewController(url: URL)
        currentController?.present(safariController!, animated: true, completion: nil)
    }
    
    fileprivate func closeSafariController() {
        if let safari = safariController, safari.isViewLoaded {
            safari.dismiss(animated: true, completion: nil)
        }
    }
    
}
