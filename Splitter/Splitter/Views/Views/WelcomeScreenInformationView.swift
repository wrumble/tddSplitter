//
//  WelcomeScreenInformationView.swift
//  Splitter
//
//  Created by Wayne Rumble on 09/08/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class WelcomeScreenInformationView: UIView {

    private let titleLogoLabel = TitleLabelLogo(accessID: AccesID.titleLogoLabel)
    private let emailTextField = SplitterTextField(accessID: AccesID.emailTextField)
    private let passwordTextField = SplitterTextField(accessID: AccesID.passwordTextField)
    private let confirmPasswordTextField = SplitterTextField(accessID: AccesID.confirmPasswordTextField)
    private let loginButton = SplitterButton(accessID: AccesID.loginButton)
    private let registerButton = SplitterButton(accessID: AccesID.registerButton)
    private var emailFieldConstraint: NSLayoutConstraint?
    private var loginButtonConstraint: NSLayoutConstraint?
    
    var onLogin: ((String, String) -> Void)?
    var onRegister: ((String, String, String) -> Void)?
    var onInvalidTextFieldInput: ((String, UITextField) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
   private func setupHierarchy() {
        addSubview(titleLogoLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        addSubview(loginButton)
        addSubview(registerButton)
    }
    
    private func setupViews() {
        passwordTextField.isSecureTextEntry = true

        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isHidden = true
                
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        subviews.forEach { subview in
            subview.pinToSuperview(edges: [.left, .right])
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLogoLabel.pinTop(to: self,
                              constant: Layout.spacer,
                              priority: .required,
                              relatedBy: .greaterThanOrEqual)
        titleLogoLabel.addHeightConstraint(with: Layout.titleLogoTextHeight)
        titleLogoLabel.pinBottom(to: emailTextField,
                                 anchor: .top,
                                 constant: -Layout.spacer,
                                 priority: .required,
                                 relatedBy: .equal)
        
        emailFieldConstraint = emailTextField.centerYToSuperview()
        emailFieldConstraint?.isActive = true
        emailTextField.addHeightConstraint(with: Layout.textFieldHeight)
        
        passwordTextField.pinTop(to: emailTextField,
                                 anchor: .bottom,
                                 constant: Layout.spacer,
                                 priority: .required,
                                 relatedBy: .equal)
        passwordTextField.addHeightConstraint(with: Layout.textFieldHeight)
        
        confirmPasswordTextField.pinTop(to: passwordTextField,
                                        anchor: .bottom,
                                        constant: Layout.spacer,
                                        priority: .required,
                                        relatedBy: .equal)
        confirmPasswordTextField.addHeightConstraint(with: Layout.textFieldHeight)
        
        loginButtonConstraint = loginButton.pinTop(to: passwordTextField,
                           anchor: .bottom,
                           constant: Layout.spacer,
                           priority: .required,
                           relatedBy: .equal)
        loginButton.addHeightConstraint(with: Layout.buttonHeight)
        
        registerButton.pinTop(to: loginButton,
                              anchor: .bottom,
                              constant: Layout.spacer,
                              priority: .required,
                              relatedBy: .equal)
        registerButton.addHeightConstraint(with: Layout.buttonHeight)
    }

    @objc private func registerButtonTapped() {
        if confirmPasswordTextField.isHidden {
            moveLoginButtonDown()
        } else {
            if registerDetailsAreValid() {
                registerNewUser()
            }
        }
    }
    
    @objc private func loginButtonTapped() {
        if !confirmPasswordTextField.isHidden {
            moveLoginButtonUp()
        } else {
            if loginDetailsAreValid() {
                loginUser()
            }
        }
    }
    
    private func loginDetailsAreValid() -> Bool {
        if containsValidEmail() &&
           containsValidPassword(textField: passwordTextField) {
            return true
        }
        return false
    }
    
    private func registerDetailsAreValid() -> Bool {
        if containsValidEmail() &&
           containsValidPassword(textField: passwordTextField) &&
           containsValidPassword(textField: confirmPasswordTextField) &&
           passwordsMatch() {
            return true
        }
        return false
    }
    
    private func containsValidEmail() -> Bool {
        if emailTextField.containsValidEmail() {
            return true
        } else {
            let errorText = Localized.invalidEmailError
            onShowToast(with: errorText, in: emailTextField)
            return false
        }
    }
    
    private func containsValidPassword(textField: UITextField) -> Bool {
        if textField.passwordReachesMinimumLength() {
            return true
        } else {
            let errorText = Localized.invalidPasswordError
            onShowToast(with: errorText, in: textField)
            return false
        }
    }
    
    private func passwordsMatch() -> Bool {
        if passwordTextField.text != confirmPasswordTextField.text {
            let errorText = Localized.passwordMismatchError
            onShowToast(with: errorText, in: confirmPasswordTextField)
            return false
        }
        return true
    }
    
    private func moveLoginButtonDown() {
        NSLayoutConstraint.deactivate([loginButtonConstraint!])
        loginButtonConstraint = loginButton.pinTop(to: confirmPasswordTextField,
                                                   anchor: .bottom,
                                                   constant: Layout.spacer,
                                                   priority: .required,
                                                   relatedBy: .equal)
        confirmPasswordTextField.isHidden = false
    }
    
    private func registerNewUser() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else { return }

        onRegister?(email, password, confirmPassword)
    }
    
    private func moveLoginButtonUp() {
        NSLayoutConstraint.deactivate([loginButtonConstraint!])
        loginButtonConstraint = loginButton.pinTop(to: passwordTextField,
                                                   anchor: .bottom,
                                                   constant: Layout.spacer,
                                                   priority: .required,
                                                   relatedBy: .equal)
        
        confirmPasswordTextField.isHidden = true
    }
    
    private func loginUser() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        
        onLogin?(email, password)
    }
    
    private func onShowToast(with text: String, in textField: UITextField) {
        onInvalidTextFieldInput?(text, textField)
    }
    
    func moveViewUpWithKeyboard(height: CGFloat) {
        NSLayoutConstraint.deactivate([emailFieldConstraint!])
        emailFieldConstraint = emailTextField.centerYToSuperview(withConstant: -height/2,
                                                                 priority: .required,
                                                                 relatedBy: .equal)
    }
    
    func moveViewDownWithKeyboard() {
        NSLayoutConstraint.deactivate([emailFieldConstraint!])
        emailFieldConstraint = emailTextField.centerYToSuperview()
    }
}
