//
//  WelcomeScreenViewController.swift
//  Splitter
//
//  Created by Wayne Rumble on 21/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit
import Firebase

class WelcomeScreenViewController: UIViewController {
    
    let emailTextField = SplitterTextField(frame: CGRect.zero, accessID: AccesID.emailTextField)
    let passwordTextField = SplitterTextField(frame: CGRect.zero, accessID: AccesID.passwordTextField)
    let confirmPasswordTextField = SplitterTextField(frame: CGRect.zero, accessID: AccesID.confirmPasswordTextField)
    let loginButton = SplitterButton(frame: CGRect.zero, accessID: AccesID.loginButton)
    let registerButton = SplitterButton(frame: CGRect.zero, accessID: AccesID.registerButton)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        
        view.backgroundColor = Color.mainBackground
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        emailTextField.pinToSuperview(edges: [.left, .right])
        emailTextField.centerYToSuperview()
        emailTextField.addHeightConstraint(with: Layout.textFieldHeight)
        
        passwordTextField.pinToSuperview(edges: [.left, .right])
        passwordTextField.pinTop(to: emailTextField,
                                 constant: Layout.textFieldHeight + Layout.spacer,
                                 priority: .required,
                                 relatedBy: .equal)
        passwordTextField.addHeightConstraint(with: Layout.textFieldHeight)
        
        confirmPasswordTextField.pinToSuperview(edges: [.left, .right])
        confirmPasswordTextField.pinTop(to: passwordTextField,
                                 constant: Layout.textFieldHeight + Layout.spacer,
                                 priority: .required,
                                 relatedBy: .equal)
        confirmPasswordTextField.addHeightConstraint(with: Layout.textFieldHeight)
        confirmPasswordTextField.isHidden = true
        
        loginButton.pinToSuperview(edges: [.left, .right])
        loginButton.pinTop(to: passwordTextField,
                           constant: Layout.textFieldHeight + Layout.spacer,
                           priority: .required,
                           relatedBy: .equal)
        loginButton.addHeightConstraint(with: Layout.buttonHeight)
        
        registerButton.pinToSuperview(edges: [.left, .right])
        registerButton.pinTop(to: loginButton,
                              constant: Layout.buttonHeight + Layout.spacer,
                              priority: .required,
                              relatedBy: .equal)
        registerButton.addHeightConstraint(with: Layout.buttonHeight)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    @objc private func registerButtonTapped() {
        loginButton.isHidden = true
        confirmPasswordTextField.isHidden = false
    }
}
