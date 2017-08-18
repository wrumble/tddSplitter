//
//  LoginRegisterUITests.swift
//  LoginRegisterUITests
//
//  Created by Wayne Rumble on 31/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
import Firebase

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
        let passwordTextField = app.secureTextFields[AccesID.passwordTextField]
        
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
        let confirmPasswordTextField = app.secureTextFields[AccesID.confirmPasswordTextField]
        
        XCTAssertFalse(confirmPasswordTextField.exists)
        registerButton.tap()
        XCTAssertTrue(confirmPasswordTextField.exists)
    }
    
    func testTappingLoginButtonAfterRegisterButtonHidesConfirmationTextFieldAgain() {
        let loginButton = app.buttons[AccesID.loginButton]
        let registerButton = app.buttons[AccesID.registerButton]
        let confirmPasswordTextField = app.secureTextFields[AccesID.confirmPasswordTextField]
        
        //dont disable login button when validating email etc
        XCTAssertFalse(confirmPasswordTextField.exists)
        registerButton.tap()
        XCTAssertTrue(confirmPasswordTextField.exists)
        loginButton.tap()
        XCTAssertFalse(confirmPasswordTextField.exists)
    }
    
    func testSuccesfullyRegisteringNewUserSeguesToMyBillsViewController() {
        register(email: "WelcomeScreenRegister@email.com",
                 password: "password",
                 confirmationPassword: "password")
        
        let titleText = NSLocalizedString("MyBillsViewControllerTitle",
                                          bundle: Bundle(for: WelcomeScreenTests.self),
                                          comment: "")
        let newControllerTitle = app.staticTexts[titleText]
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: newControllerTitle, handler: nil)
        waitForExpectations(timeout: 10, handler: { error in
            if let error = error {
                XCTFail(String(describing: error))
            } else {
                self.removeUser()
                XCTAssertTrue(true)
            }
        })
    }
    
    func testLoginButtonDoesntSegueWhenEmailIsInvalid() {
        let emailTextField = app.textFields[AccesID.emailTextField]
        //let passwordTextField = app.secureTextFields[AccesID.passwordTextField]
        let loginButton = app.buttons[AccesID.loginButton]
        let invalidEmail = "invalid@email"
        //let password = "123456"
        
        XCTAssertFalse(loginButton.isEnabled)
        
        emailTextField.tap()
        emailTextField.typeText(invalidEmail)
//        passwordTextField.tap()
//        passwordTextField.typeText(password)
        
        XCTAssertFalse(loginButton.isEnabled)
    }
    
    func testLoginButtonEnabledWhenEmailValid() {
        let emailTextField = app.textFields[AccesID.emailTextField]
        //let passwordTextField = app.secureTextFields[AccesID.passwordTextField]
        let loginButton = app.buttons[AccesID.loginButton]
        let invalidEmail = "valid@email.com"
        //let password = "123456"
        
        XCTAssertFalse(loginButton.isEnabled)
        
        emailTextField.tap()
        emailTextField.typeText(invalidEmail)
//        passwordTextField.tap()
//        passwordTextField.typeText(password)
        
        XCTAssertTrue(loginButton.isEnabled)
    }
    
    func testRegisteringUsedPasswordDisplaysAlert() {
        
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
    
    //This isnt working
    func removeUser() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        if let user = Auth.auth().currentUser {
            user.delete(completion: { error in
                if let error = error {
                    print(error)
                }
            })
        }
    }
}
