//
//  WelcomScreenTestHelper.swift
//  WelcomeScreenTests
//
//  Created by Wayne Rumble on 23/08/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
import Foundation

class WelcomeScreenTestHelper: XCTestCase {
    
    let app = XCUIApplication()
    
    func login(with email: String, and password: String, completion: (() -> Void)? = nil) {
        let emailTextField = app.textFields[AccesID.emailTextField]
        let passwordTextField = app.secureTextFields[AccesID.passwordTextField]
        let loginButton = app.buttons[AccesID.loginButton]
        
        emailTextField.tap()
        emailTextField.typeText(email)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        loginButton.tap()
        
        completion?()
    }
    
    func register(email: String, password: String, confirmationPassword: String, completion: (() -> Void)? = nil) {
        let emailTextField = app.textFields[AccesID.emailTextField]
        let passwordTextField = app.secureTextFields[AccesID.passwordTextField]
        let confirmPasswordTextField = app.secureTextFields[AccesID.confirmPasswordTextField]
        let registerButton = app.buttons[AccesID.registerButton]
        
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
