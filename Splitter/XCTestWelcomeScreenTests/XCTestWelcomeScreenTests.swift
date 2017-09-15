//
//  XCTestWelcomeScreenTests.swift
//  XCTestWelcomeScreenTests
//
//  Created by Wayne Rumble on 15/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest

class XCTestWelcomeScreenTests: XCTestCase {
    
    let app = XCUIApplication()
    let password = "password"
    let registeredEmail = "alreadyregistereduser@email.com"
    
    override func setUp() {
        super.setUp()
        app.launch()
    }
    
    func testTappingRegisterButtonShowsConfirmPasswordTextField() {
        let registerButton = app.buttons[AccesID.registerButton]
        let confirmPasswordTextField = app.secureTextFields[AccesID.confirmPasswordTextField]
        
        XCTAssertFalse(confirmPasswordTextField.exists)
        registerButton.tap()
        XCTAssertTrue(confirmPasswordTextField.exists)
    }
    
    func testTappingLoginButtonAfterRegisterButtonHidesConfirmationPasswordTextField() {
        let loginButton = app.buttons[AccesID.loginButton]
        let registerButton = app.buttons[AccesID.registerButton]
        let confirmPasswordTextField = app.secureTextFields[AccesID.confirmPasswordTextField]
        
        XCTAssertFalse(confirmPasswordTextField.exists)
        registerButton.tap()
        XCTAssertTrue(confirmPasswordTextField.exists)
        loginButton.tap()
        XCTAssertFalse(confirmPasswordTextField.exists)
    }
    
    func testSuccesfullyRegisteringNewUserSeguesToMyBillsViewController() {
        let createdUserEmail = createEmail(with: "\(#function)")
        
        register(email: createdUserEmail,
                 password: password,
                 confirmationPassword: password)
        
        let titleText = NSLocalizedString("MyBillsViewControllerTitle",
                                          bundle: Bundle(for: XCTestWelcomeScreenTests.self),
                                          comment: "")
        let newControllerTitle = app.staticTexts[titleText]
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: newControllerTitle, handler: nil)
        waitForExpectations(timeout: 10, handler: { error in
            if let error = error {
                XCTFail(String(describing: error))
            } else {
                XCTAssertTrue(true)
            }
        })
    }
    
    func testLoginButtonPerformsSegueWithValidEmailAndPassword() {
        let titleText = NSLocalizedString("MyBillsViewControllerTitle",
                                          bundle: Bundle(for: XCTestWelcomeScreenTests.self),
                                          comment: "")
        let newControllerTitle = app.staticTexts[titleText]
        let exists = NSPredicate(format: "exists == 1")
        
        login(email: registeredEmail, password: password)
        
        expectation(for: exists, evaluatedWith: newControllerTitle, handler: nil)
        waitForExpectations(timeout: 10, handler: { error in
            if let error = error {
                XCTFail(String(describing: error))
            } else {
                XCTAssertTrue(true)
            }
        })
    }
    
    func login(email: String, password: String) {
        let emailTextField = app.textFields[AccesID.emailTextField]
        let passwordTextField = app.secureTextFields[AccesID.passwordTextField]
        let loginButton = app.buttons[AccesID.loginButton]
        
        emailTextField.tap()
        emailTextField.typeText(email)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        loginButton.tap()
    }
    
    func register(email: String, password: String, confirmationPassword: String) {
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
    }
}
