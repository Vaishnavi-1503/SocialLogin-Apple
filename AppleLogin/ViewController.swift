//
//  ViewController.swift
//  AppleLogin
//
//  Created by vaishanavi.sasane on 08/08/24.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureLoginButton()
    }

    /// Login button confifguration
    func configureLoginButton() {
        let button = ASAuthorizationAppleIDButton()
        button.center = view.center
        button.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    /// Login button action method
    @objc func tapLoginButton() {
        let appleIDDetails = ASAuthorizationAppleIDProvider()
        let request = appleIDDetails.createRequest()
        request.requestedScopes = [.email,.fullName]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
}

/// Apple authentication delegate methods
extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let detail = authorization.credential as? ASAuthorizationAppleIDCredential {
            debugPrint(detail.user)
            debugPrint(detail.fullName ?? "")
            debugPrint(detail.email ?? "")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        debugPrint(error.localizedDescription)
    }
}

