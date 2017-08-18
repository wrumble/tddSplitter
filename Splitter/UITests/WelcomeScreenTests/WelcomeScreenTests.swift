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
    
    var createdUserEmails = [String]()
    let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
        super.setUp()
    }
    
    override func tearDown() {
        createdUserEmails.forEach { email in
            self.removeUser(with: email)
        }
        super.tearDown()
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
    
    func testRegisterButtonPerformsSegueWithValidEmailAndPassword() {
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
        let email = createEmail(with: "\(#function)")
        let password = "password"
        
        createdUserEmails.append(email)
        register(email: email,
                 password: password,
                 confirmationPassword: password)
        
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
                XCTAssertTrue(true)
            }
        })
    }
    
    func testLoginButtonPerformsSegueWithValidEmailAndPassword() {
        let validEmail = "alreadyRegisteredUser@email.com"
        let validPassword = "password"
        
        createdUserEmails.append(validEmail)
        login(email: validEmail, password: validPassword)
        
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
    
    func createEmail(with functionName: String) -> String {
        let badchar = CharacterSet(charactersIn: "()")
        let cleanedFunctionName = functionName.components(separatedBy: badchar).joined()
        return "\(cleanedFunctionName)@email.com"
    }
    
    func removeUser(with email: String) {
        Auth.auth().signIn(withEmail: email, password: "password", completion: { (user, _) in
            if user != nil {
                if let signedInUser = Auth.auth().currentUser {
                    signedInUser.delete()
                }
            } else {
                print("No user with email: \(email)")
            }
        })
    }
}
