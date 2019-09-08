//
//  UIViewController+alert.swift
//  FacadeAuth
//
//  Created by user on 10.08.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showMessageAlert(title: String?, message: String? = nil,
                          buttonTitle: String? = "Ок", action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default) { _ in
            if let action = action { action() }
        })
        self.present(alert, animated: true, completion: nil)
    }
    
}
