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
    
    private var currentUser: SplitterUser? {
        didSet {
            let nextViewController = MyBillsViewController()
            nextViewController.currentUser = self.currentUser
            present(nextViewController, animated: true)
        }
    }
    
    // swiftlint:disable line_length
    private let firebaseData = FirebaseData()
    private let titleLogoLabel = TitleLabelLogo(frame: CGRect.zero, accessID: AccesID.titleLogoLabel)
    private let emailTextField = SplitterTextField(frame: CGRect.zero, accessID: AccesID.emailTextField)
    private let passwordTextField = SplitterTextField(frame: CGRect.zero, accessID: AccesID.passwordTextField)
    private let confirmPasswordTextField = SplitterTextField(frame: CGRect.zero, accessID: AccesID.confirmPasswordTextField)
    private let loginButton = SplitterButton(frame: CGRect.zero, accessID: AccesID.loginButton)
    private let registerButton = SplitterButton(frame: CGRect.zero, accessID: AccesID.registerButton)
    // swiftlint:enable line_length
    
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
        setupKeyboard()
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
    
    private func registerNewUser() {
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirmationPassword = confirmPasswordTextField.text
        if let password = password, password == confirmationPassword {
            firebaseData.createUser(email: email!, password: password, completion: { (error, splitterUser) in
                if let error = error {
                    //raise error
                    print(error)
                } else {
                    self.currentUser = splitterUser
                }
            })
        } else {
            //raise password mismatch error
        }
    }
    
    @objc private func registerButtonTapped() {
        if confirmPasswordTextField.isHidden {
            animateLoginButton()
        } else {
            registerNewUser()
        }
    }
    
    @objc private func loginButtonTapped() {
        if !confirmPasswordTextField.isHidden {
            animateLoginButton()
            self.view.layoutSubviews()
        } else {
            //segue to next vc
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
            self.view.layoutSubviews()
        })
    }
    
    private func moveLoginButtonUp() {
        //Move the loginButton up, when it has finished moving hide the confirmationPasswordTextView
        UIView.animate(withDuration: 0.3, animations: {
            self.loginButton.frame.origin.y -= Layout.loginButtonYMovement
        }, completion: { _ in
            self.confirmPasswordTextField.isHidden = true
        })
    }
}

extension UIViewController {
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(sender:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(sender:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = Layout.welcomeScreenKeyboardMovement
    }
    
    @objc private func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
}
