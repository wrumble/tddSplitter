//
//  LoginRegisterUITests.swift
//  LoginRegisterUITests
//
//  Created by Wayne Rumble on 31/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest

class WelcomeScreenTests: XCTestCase {
    
    var createdUserEmail: String?
    
    let registeredEmail = "alreadyregistereduser@email.com"
    
    let app = XCUIApplication()
    let welcomeScreenHelper = WelcomeScreenTestHelper()
    let emailHelper = EmailTestHelper()
    let firebaseHelper = FirebaseTestHelper()
    
    override func setUp() {
        app.launch()
        super.setUp()
    }
    
    override func tearDown() {
        if let email = createdUserEmail {
            firebaseHelper.removeUser(with: email)
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
        
        //dont disable login button when validating email or password
        XCTAssertFalse(confirmPasswordTextField.exists)
        registerButton.tap()
        XCTAssertTrue(confirmPasswordTextField.exists)
        loginButton.tap()
        XCTAssertFalse(confirmPasswordTextField.exists)
    }
    
    func testSuccesfullyRegisteringNewUserSeguesToMyBillsViewController() {
        createdUserEmail = emailHelper.createEmail(with: "\(#function)")
        let password = "password"
        
        welcomeScreenHelper.register(email: createdUserEmail!,
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
    func testRegisteringWithInvalidEmailDisplaysLocalisedError() {
        let email = "invalid@email"
        let password = "password"
        
        welcomeScreenHelper.register(email: email,
                                     password: password,
                                     confirmationPassword: password,
                                     completion: {
                                        
                                        let localisedErrorMessage = NSLocalizedString("InvalidEmailError",
                                                                                      bundle: Bundle(for: WelcomeScreenTests.self),
                                                                                      comment: "")
                                        XCTAssert(self.app.staticTexts[localisedErrorMessage].exists)
        })
    }
    
    func testRegisteringWithInvalidPasswordDisplaysLocalisedError() {
        let email = emailHelper.createEmail(with: "\(#function)")
        let password = "12345"
        
        welcomeScreenHelper.register(email: email,
                                     password: password,
                                     confirmationPassword: password,
                                     completion: {
                                        
                                        let localisedErrorMessage = NSLocalizedString("InvalidPasswordError",
                                                                                      bundle: Bundle(for: WelcomeScreenTests.self),
                                                                                      comment: "")
                                        XCTAssert(self.app.staticTexts[localisedErrorMessage].exists)
        })
    }
    
    func testRegisteringWithInvalidConfirmationPasswordDisplaysLocalisedError() {
        let email = emailHelper.createEmail(with: "\(#function)")
        let password = "123456"
        let confirmationPassword = "12345"
        
        welcomeScreenHelper.register(email: email,
                                     password: password,
                                     confirmationPassword: confirmationPassword,
                                     completion: {
                                        
                                        let localisedErrorMessage = NSLocalizedString("InvalidPasswordError",
                                                                                      bundle: Bundle(for: WelcomeScreenTests.self),
                                                                                      comment: "")
                                        XCTAssert(self.app.staticTexts[localisedErrorMessage].exists)
        })
    }
    
    func testRegisteringWithDifferentPasswordsDisplaysLocalisedError() {
        let email = emailHelper.createEmail(with: "\(#function)")
        let password = "123456"
        let confirmationPassword = "1234567"
        
        welcomeScreenHelper.register(email: email,
                                     password: password,
                                     confirmationPassword: confirmationPassword,
                                     completion: {
                                        
                                        let localisedErrorMessage = NSLocalizedString("PasswordMismatchError",
                                                                                      bundle: Bundle(for: WelcomeScreenTests.self),
                                                                                      comment: "")
                                        XCTAssert(self.app.staticTexts[localisedErrorMessage].exists)
        })
    }
    
    func testRegisteringWithUsedEmailDisplaysFirebaseError() {
        let email = registeredEmail
        let password = "password"
        
        welcomeScreenHelper.register(email: email,
                                     password: password,
                                     confirmationPassword: password,
                                     completion: {
                                        
            let firebaseErrorMessage = "The email address is already in use by another account."
            XCTAssert(self.app.staticTexts[firebaseErrorMessage].exists)
        })
    }
    
    func testLoginButtonPerformsSegueWithValidEmailAndPassword() {
        let validEmail = registeredEmail
        let validPassword = "password"
        
        welcomeScreenHelper.login(with: validEmail, and: validPassword)
        
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
}
