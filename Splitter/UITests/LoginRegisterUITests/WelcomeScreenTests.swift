//
//  LoginRegisterUITests.swift
//  LoginRegisterUITests
//
//  Created by Wayne Rumble on 31/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
@testable import Splitter

class WelcomeScreenTests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
        super.setUp()
    }
    
    func testHasLogoLabel() {
        let logoLabelText = NSLocalizedString("SplitterTitleLogoText",
                                              bundle: Bundle(for: WelcomeScreenTests.self),
                                              comment: "")

        XCTAssert(app.staticTexts[logoLabelText].exists)
    }
    
    func testHasEmailTextField() {
        let emailTextField = app.textFields[AccesID.emailTextField]
        
        XCTAssertTrue(emailTextField.isHittable)
    }
    
    func testHasPasswordTextField() {
        let passwordTextField = app.textFields[AccesID.passwordTextField]
        
        XCTAssertTrue(passwordTextField.isHittable)
    }
    
    func testHasLoginButton() {
        let loginButton = app.buttons[AccesID.loginButton]
        
        XCTAssertTrue(loginButton.isHittable)
    }
    
    func testHasRegisterButton() {
        let registerButton = app.buttons[AccesID.registerButton]
        
        XCTAssertTrue(registerButton.isHittable)
    }
    
    func testTappingRegisterButtonShowsConfirmPasswordTextField() {
        let registerButton = app.buttons[AccesID.registerButton]
        let confirmPasswordTextField = app.textFields[AccesID.confirmPasswordTextField]
        
        XCTAssertFalse(confirmPasswordTextField.exists)
        registerButton.tap()
        XCTAssertTrue(confirmPasswordTextField.exists)
    }
    
    func testTappingLoginButtonAfterRegistrButtonHidesConfirmationTextFieldAgain() {
        let loginButton = app.buttons[AccesID.loginButton]
        let registerButton = app.buttons[AccesID.registerButton]
        let confirmPasswordTextField = app.textFields[AccesID.confirmPasswordTextField]
        
        XCTAssertFalse(confirmPasswordTextField.exists)
        registerButton.tap()
        XCTAssertTrue(confirmPasswordTextField.exists)
        loginButton.tap()
        XCTAssertFalse(confirmPasswordTextField.exists)
    }
    
    func testSuccesfullyRegisteringNewUserSeguesToMyBillsViewController() {
        let emailTextField = app.textFields[AccesID.emailTextField]
        let passwordTextField = app.textFields[AccesID.passwordTextField]
        let confirmPasswordTextField = app.textFields[AccesID.confirmPasswordTextField]
        let registerButton = app.buttons[AccesID.registerButton]
        
        emailTextField.typeText("test@email.com")
        passwordTextField.typeText("password")
        confirmPasswordTextField.typeText("password")
        
        registerButton.tap()
        
        XCTAssert(app.staticTexts["My Bills"].exists)
    }
}
