//
//  WelcomeScreenInformationView.swift
//  Splitter
//
//  Created by Wayne Rumble on 09/08/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class WelcomeScreenInformationView: UIView {

    // swiftlint:disable line_length
    private let titleLogoLabel = TitleLabelLogo(frame: CGRect.zero, accessID: AccesID.titleLogoLabel)
    private let emailTextField = SplitterTextField(frame: CGRect.zero, accessID: AccesID.emailTextField)
    private let passwordTextField = SplitterTextField(frame: CGRect.zero, accessID: AccesID.passwordTextField)
    private let confirmPasswordTextField = SplitterTextField(frame: CGRect.zero, accessID: AccesID.confirmPasswordTextField)
    private let loginButton = SplitterButton(frame: CGRect.zero, accessID: AccesID.loginButton)
    private let registerButton = SplitterButton(frame: CGRect.zero, accessID: AccesID.registerButton)
    private var emailFieldConstraint: NSLayoutConstraint?
    private var loginButtonConstraint: NSLayoutConstraint?
    // swiftlint:enable line_length
    
    var onLogin: ((String, String) -> Void)?
    var onRegister: ((String, String, String) -> Void)?
    
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
        
        loginButton.isEnabled = false
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        emailTextField.addTarget(self, action: #selector(textFieldInputDetected), for: .editingChanged)
    }
    
    private func setupLayout() {
        subviews.forEach { subview in
            subview.pinToSuperview(edges: [.left, .right])
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLogoLabel.pinTop(to: self,
                              constant: Layout.spacer,
                              priority: UILayoutPriorityRequired,
                              relatedBy: .greaterThanOrEqual)
        titleLogoLabel.addHeightConstraint(with: Layout.titleLogoTextHeight)
        titleLogoLabel.pinBottom(to: emailTextField,
                                 anchor: .top,
                                 constant: -Layout.spacer,
                                 priority: UILayoutPriorityRequired,
                                 relatedBy: .equal)
        
        emailFieldConstraint = emailTextField.centerYToSuperview()
        emailFieldConstraint?.isActive = true
        emailTextField.addHeightConstraint(with: Layout.textFieldHeight)
        
        passwordTextField.pinTop(to: emailTextField,
                                 anchor: .bottom,
                                 constant: Layout.spacer,
                                 priority: UILayoutPriorityRequired,
                                 relatedBy: .equal)
        passwordTextField.addHeightConstraint(with: Layout.textFieldHeight)
        
        confirmPasswordTextField.pinTop(to: passwordTextField,
                                        anchor: .bottom,
                                        constant: Layout.spacer,
                                        priority: UILayoutPriorityRequired,
                                        relatedBy: .equal)
        confirmPasswordTextField.addHeightConstraint(with: Layout.textFieldHeight)
        
        loginButtonConstraint = loginButton.pinTop(to: passwordTextField,
                           anchor: .bottom,
                           constant: Layout.spacer,
                           priority: UILayoutPriorityRequired,
                           relatedBy: .equal)
        loginButton.addHeightConstraint(with: Layout.buttonHeight)
        
        registerButton.pinTop(to: loginButton,
                              anchor: .bottom,
                              constant: Layout.spacer,
                              priority: UILayoutPriorityRequired,
                              relatedBy: .equal)
        registerButton.addHeightConstraint(with: Layout.buttonHeight)
    }

    @objc private func registerButtonTapped() {
        if confirmPasswordTextField.isHidden {
            moveLoginButtonDown()
        } else {
            registerNewUer()
        }
    }
    
    @objc private func loginButtonTapped() {
        if !confirmPasswordTextField.isHidden {
            moveLoginButtonUp()
        } else {
            loginUser()
        }
    }
    
    @objc private func textFieldInputDetected() {
        if confirmPasswordTextField.isHidden &&
            loginTextFieldInputsAreValid() {
            loginButton.isEnabled = true
        }
    }
    
    private func loginTextFieldInputsAreValid() -> Bool {
        if emailTextField.containsValidEmail() {
            return true
        }
        return false
    }
    
    private func moveLoginButtonDown() {
        NSLayoutConstraint.deactivate([loginButtonConstraint!])
        loginButtonConstraint = loginButton.pinTop(to: confirmPasswordTextField,
                                                   anchor: .bottom,
                                                   constant: Layout.spacer,
                                                   priority: UILayoutPriorityRequired,
                                                   relatedBy: .equal)
        confirmPasswordTextField.isHidden = false
    }
    
    private func registerNewUer() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        onRegister?(email, password, confirmPassword)
    }
    
    private func moveLoginButtonUp() {
        NSLayoutConstraint.deactivate([loginButtonConstraint!])
        loginButtonConstraint = loginButton.pinTop(to: passwordTextField,
                                                   anchor: .bottom,
                                                   constant: Layout.spacer,
                                                   priority: UILayoutPriorityRequired,
                                                   relatedBy: .equal)
        
        confirmPasswordTextField.isHidden = true
    }
    
    private func loginUser() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        onLogin?(email, password)
    }
    
    func moveViewUpWithKeyboard(height: CGFloat) {
        NSLayoutConstraint.deactivate([emailFieldConstraint!])
        emailFieldConstraint = emailTextField.centerYToSuperview(withConstant: -height/2,
                                                                 priority: UILayoutPriorityRequired,
                                                                 relatedBy: .equal)
    }
    
    func moveViewDownWithKeyboard() {
        NSLayoutConstraint.deactivate([emailFieldConstraint!])
        emailFieldConstraint = emailTextField.centerYToSuperview()
    }
}
