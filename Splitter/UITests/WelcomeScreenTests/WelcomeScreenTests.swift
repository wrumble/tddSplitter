//
//  LoginRegisterUITests.swift
//  LoginRegisterUITests
//
//  Created by Wayne Rumble on 31/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
// swiftlint:disable line_length

class WelcomeScreenTests: XCTestCase {
    
    var createdUserEmail: String?
    
    let password = "password"
    let shortPassword = "passw"
    let differentPassword = "differentPassword"
    let registeredEmail = "alreadyregistereduser@email.com"
    let invalidEmail = "invalid@email"
    
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
        let emailTextField = app.textFields[TestAccesID.emailTextField]
        
        XCTAssertTrue(emailTextField.isHittable)
    }
    
    func testHasPasswordTextField() {
        let passwordTextField = app.secureTextFields[TestAccesID.passwordTextField]
        
        XCTAssertTrue(passwordTextField.isHittable)
    }
    
    func testHasLoginButton() {
        let loginButton = app.buttons[TestAccesID.loginButton]
        
        XCTAssertTrue(loginButton.isHittable)
    }
    
    func testHasRegisterButton() {
        let registerButton = app.buttons[TestAccesID.registerButton]
        
        XCTAssertTrue(registerButton.isHittable)
    }
    
    func testTappingRegisterButtonShowsConfirmPasswordTextField() {
        let registerButton = app.buttons[TestAccesID.registerButton]
        let confirmPasswordTextField = app.secureTextFields[TestAccesID.confirmPasswordTextField]
        
        XCTAssertFalse(confirmPasswordTextField.exists)
        registerButton.tap()
        XCTAssertTrue(confirmPasswordTextField.exists)
    }
    
    func testRegisterButtonPerformsSegueWithValidEmailAndPassword() {
        let loginButton = app.buttons[TestAccesID.loginButton]
        let registerButton = app.buttons[TestAccesID.registerButton]
        let confirmPasswordTextField = app.secureTextFields[TestAccesID.confirmPasswordTextField]
        
        //dont disable login button when validating email or password
        XCTAssertFalse(confirmPasswordTextField.exists)
        registerButton.tap()
        XCTAssertTrue(confirmPasswordTextField.exists)
        loginButton.tap()
        XCTAssertFalse(confirmPasswordTextField.exists)
    }
    
    func testSuccesfullyRegisteringNewUserSeguesToMyBillsViewController() {
        createdUserEmail = emailHelper.createEmail(with: "\(#function)")
        
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
        let localisedErrorMessage = NSLocalizedString("InvalidEmailError",
                                                      bundle: Bundle(for: WelcomeScreenTests.self),
                                                      comment: "")
        let predicate = NSPredicate(format: "exists == true")
        let query = self.app.
        
        welcomeScreenHelper.register(email: invalidEmail,
                                     password: password,
                                     confirmationPassword: password,
                                     completion: {
                                        self.expectation(for: predicate, evaluatedWith: query, handler: nil)
                                        self.waitForExpectations(timeout: 10, handler: nil)
                                        XCTAssert(self.app.staticTexts[localisedErrorMessage].exists)
        })
    }
    
    func testRegisteringWithInvalidPasswordDisplaysLocalisedError() {
        let email = emailHelper.createEmail(with: "\(#function)")
        
        welcomeScreenHelper.register(email: email,
                                     password: password,
                                     confirmationPassword: shortPassword,
                                     completion: {
                                        
            let localisedErrorMessage = NSLocalizedString("InvalidPasswordError",
                                                          bundle: Bundle(for: WelcomeScreenTests.self),
                                                          comment: "")
            XCTAssert(self.app.staticTexts[localisedErrorMessage].exists)
        })
    }
    
    func testRegisteringWithInvalidConfirmationPasswordDisplaysLocalisedError() {
        let email = emailHelper.createEmail(with: "\(#function)")
        
        welcomeScreenHelper.register(email: email,
                                     password: password,
                                     confirmationPassword: shortPassword,
                                     completion: {
                                        
            let localisedErrorMessage = NSLocalizedString("InvalidPasswordError",
                                                          bundle: Bundle(for: WelcomeScreenTests.self),
                                                          comment: "")
            XCTAssert(self.app.staticTexts[localisedErrorMessage].exists)
        })
    }
    
    func testRegisteringWithDifferentPasswordsDisplaysLocalisedError() {
        let email = emailHelper.createEmail(with: "\(#function)")
        
        welcomeScreenHelper.register(email: email,
                                     password: password,
                                     confirmationPassword: differentPassword,
                                     completion: {
                                        
            let localisedErrorMessage = NSLocalizedString("PasswordMismatchError",
                                                          bundle: Bundle(for: WelcomeScreenTests.self),
                                                          comment: "")
            XCTAssert(self.app.staticTexts[localisedErrorMessage].exists)
        })
    }
    
    func testRegisteringWithUsedEmailDisplaysFirebaseError() {
        
        welcomeScreenHelper.register(email: registeredEmail,
                                     password: password,
                                     confirmationPassword: password,
                                     completion: {
                                        
            let firebaseErrorMessage = "The email address is already in use by another account."
            XCTAssert(self.app.staticTexts[firebaseErrorMessage].exists)
        })
    }
    
    func testLoginButtonPerformsSegueWithValidEmailAndPassword() {
        welcomeScreenHelper.login(with: registeredEmail, and: password)
        
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
    
    func testLoginWithInvalidEmailDisplaysLocalisedError() {
        welcomeScreenHelper.login(with: invalidEmail,
                                  and: password,
                                  completion: {
                                    
            let localisedErrorMessage = NSLocalizedString("InvalidEmailError",
                                                          bundle: Bundle(for: WelcomeScreenTests.self),
                                                          comment: "")
            XCTAssert(self.app.staticTexts[localisedErrorMessage].exists)
        })
    }
    
    func testLoginWithIncorrectEmailDisplaysLocalisedError() {
        welcomeScreenHelper.login(with: invalidEmail,
                                  and: password,
                                  completion: {
                                    
            let firebaseErrorMessage = "There is no user record corresponding to this identifier. The user may have been deleted."
            XCTAssert(self.app.staticTexts[firebaseErrorMessage].exists)
        })
    }
    
    func testLoginWithInvalidPasswordDisplaysLocalisedError() {
        welcomeScreenHelper.login(with: invalidEmail,
                                  and: shortPassword,
                                  completion: {
                                    
            let localisedErrorMessage = NSLocalizedString("InvalidPasswordError",
                                                                                  bundle: Bundle(for: WelcomeScreenTests.self),
                                                                                  comment: "")
            XCTAssert(self.app.staticTexts[localisedErrorMessage].exists)
        })
    }
    
    func testLoginWithIncorrectPasswordDisplaysLocalisedError() {
        let wrongPassword = "wrongPassword"
        welcomeScreenHelper.login(with: invalidEmail,
                                  and: wrongPassword,
                                  completion: {
                                    
            let firebaseErrorMessage = "The password is invalid or the user does not have a password"
            XCTAssert(self.app.staticTexts[firebaseErrorMessage].exists)
        })
    }
}
