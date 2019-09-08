//
//  ViewController.swift
//  FacadeAuth
//
//  Created by user on 28.06.2019.
//  Copyright © 2019 Information Technologies, LLC. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    let authService = AuthServiceFacade()
    
    @IBOutlet var authButtons: [UIButton]! {
        didSet {
            for btn in authButtons {
                btn.layer.cornerRadius = btn.bounds.height * 0.2
                btn.layer.masksToBounds = true
            }
        }
    }
    
    @IBOutlet var infoLabel: UILabel!

    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        print("loginAction")
        guard let id = sender.restorationIdentifier,
        let type = AuthServiceFacade.AuthResourceType(rawValue: id) else {
            assertionFailure("Set button restoration Identifier")
            return
        }
        authService.login(with: type, from: self) { [weak self] (user, error) in
            guard let userObj = user, error == nil else {
                self?.showMessageAlert(title: "Ошибка", message: "Не удалось войти")
                return
            }
            LoginProcessController.setupCurrentUser(user: userObj)
            self?.completeAuth()
        }
        
    }
    
    private func completeAuth() {
        // close safari auth view
        navigationController?.popViewController(animated: true)
        
        guard let startVC = storyboard?.instantiateViewController(withIdentifier: "StartTrekController") else { assertionFailure("not have the StartTrekController"); return }
        navigationController?.present(startVC, animated: true, completion: nil)
    }

}

