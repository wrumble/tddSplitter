//
//  WelcomScreenTestHelper.swift
//  WelcomeScreenTests
//
//  Created by Wayne Rumble on 23/08/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
import Foundation

enum TestAccesID {
    static let titleLogoLabel = "Title"
    static let emailTextField = "Email"
    static let passwordTextField = "Password"
    static let confirmPasswordTextField = "ConfirmPassword"
    static let loginButton = "Login"
    static let registerButton = "Register"
    static let toastLabel = "Toast"
}

class WelcomeScreenTestHelper: XCTestCase {
    
    let app = XCUIApplication()
    
    func login(with email: String, and password: String, completion: (() -> Void)? = nil) {
        let emailTextField = app.textFields[TestAccesID.emailTextField]
        let passwordTextField = app.secureTextFields[TestAccesID.passwordTextField]
        let loginButton = app.buttons[TestAccesID.loginButton]
        
        emailTextField.tap()
        emailTextField.typeText(email)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        loginButton.tap()
        
        completion?()
    }
    
    func register(email: String, password: String, confirmationPassword: String, completion: (() -> Void)? = nil) {
        let emailTextField = app.textFields[TestAccesID.emailTextField]
        let passwordTextField = app.secureTextFields[TestAccesID.passwordTextField]
        let confirmPasswordTextField = app.secureTextFields[TestAccesID.confirmPasswordTextField]
        let registerButton = app.buttons[TestAccesID.registerButton]
        
        emailTextField.tap()
        emailTextField.typeText(email)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        registerButton.tap()
        confirmPasswordTextField.tap()
        confirmPasswordTextField.typeText(confirmationPassword)
        registerButton.tap()
        
        completion?()
    }
}
