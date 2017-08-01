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
    
    let firebaseData = FirebaseData()
    
    let titleLogoLabel = TitleLabelLogo(frame: CGRect.zero, accessID: AccesID.titleLogoLabel)
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
        
        view.addSubview(titleLogoLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        applyCommonLayoutFeaturesToAllViews()
        placeTitleLogoLabel()
        placeEmailTextField()
        placePasswordTextField()
        placePasswordConfirmationTextField()
        placeLoginButton()
        placeRegisterButton()
    }
    
    private func applyCommonLayoutFeaturesToAllViews() {
        view.subviews.forEach { subview in
            subview.pinToSuperview(edges: [.left, .right])
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func placeTitleLogoLabel() {
        let titleLogoLabelY = view.frame.height/4.5
        titleLogoLabel.pinTop(to: view, constant: titleLogoLabelY)
        titleLogoLabel.addHeightConstraint(with: Layout.titleLogoTextHeight)
    }
    
    private func placeEmailTextField() {
        emailTextField.centerYToSuperview()
        emailTextField.addHeightConstraint(with: Layout.textFieldHeight)
    }
    
    private func placePasswordTextField() {
        passwordTextField.pinTop(to: emailTextField,
                                 constant: Layout.textFieldHeight + Layout.spacer,
                                 priority: .required,
                                 relatedBy: .equal)
        passwordTextField.addHeightConstraint(with: Layout.textFieldHeight)
    }
    
    private func placePasswordConfirmationTextField() {
        confirmPasswordTextField.pinTop(to: passwordTextField,
                                        constant: Layout.textFieldHeight + Layout.spacer,
                                        priority: .required,
                                        relatedBy: .equal)
        confirmPasswordTextField.addHeightConstraint(with: Layout.textFieldHeight)
        confirmPasswordTextField.isHidden = true
    }
    
    private func placeLoginButton() {
        loginButton.pinTop(to: passwordTextField,
                           constant: Layout.textFieldHeight + Layout.spacer,
                           priority: .required,
                           relatedBy: .equal)
        loginButton.addHeightConstraint(with: Layout.buttonHeight)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func placeRegisterButton() {
        registerButton.pinTop(to: loginButton,
                              constant: Layout.buttonHeight + Layout.spacer,
                              priority: .required,
                              relatedBy: .equal)
        registerButton.addHeightConstraint(with: Layout.buttonHeight)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func registerButtonTapped() {
        if confirmPasswordTextField.isHidden {
            animateLoginButton()
        } else {
            
        }
    }
    
    private func registerNewUser() {
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmationPassword = confirmPasswordTextField.text
        if let password = password, password == confirmationPassword {
            firebaseData.createUser(email: email!, password: password, completion: { (error, firebaseUser) in
                if let error = error {
                    //raise error
                } else {
                    firebaseUser?.uid
                }
            })
        } else {
            //raise password mismatch error
        }
    }
    
    @objc private func loginButtonTapped() {
        if !confirmPasswordTextField.isHidden {
            animateLoginButton()
        } else {
            //segue to sign up to stripe onboarding screens
        }
    }
    
    private func animateLoginButton() {
        if confirmPasswordTextField.isHidden {
            moveLoginButtonDown()
        } else {
            moveLoginButtonUp()
        }
    }
    
    private func moveLoginButtonDown() {
        //Move loginButton down revealing confirmationPasswordTextView behind it
        UIView.animate(withDuration: 0.3, animations: {
            self.loginButton.frame.origin.y += Layout.loginButtonYMovement
            self.confirmPasswordTextField.isHidden = false
        })
    }
    
    private func moveLoginButtonUp() {
        //Move the loginButton up, when login button has finished moving hide the confirmationPasswordTextView
        UIView.animate(withDuration: 0.3, animations: {
            self.loginButton.frame.origin.y -= Layout.loginButtonYMovement
        }, completion: { isComplete in
            if isComplete {
                self.confirmPasswordTextField.isHidden = true
            }
        })
    }
}
