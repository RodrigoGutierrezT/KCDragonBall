//
//  LoginViewController.swift
//  KCDragonBall
//
//  Created by Rodrigo on 28-09-24.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    // MARK: - Model
    private let networkModel: NetworkModel
    
    // MARK: - Initializers
    init(networkModel: NetworkModel = .shared) {
        self.networkModel = networkModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        
        guard let email = emailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else{
            return
        }
        
        networkModel.login(user: email, password: password) { result in
            switch result {
                case .success:
                DispatchQueue.main.async {
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController()
                }
                case .failure:
                    print("Failed to login")
                    break
            }
        }
        
    }
    
}
