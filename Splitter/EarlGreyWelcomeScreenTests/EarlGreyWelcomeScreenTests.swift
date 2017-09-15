//
//  WelcomeScreenTests.swift
//  WelcomeScreenTests
//
//  Created by Wayne Rumble on 14/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
import EarlGrey
@testable import Splitter

// swiftlint:disable type_body_length
class WelcomeScreenTests: XCTestCase {
    
    let password = "password"
    let shortPassword = "passw"
    let differentPassword = "differentPassword"
    let wrongPassword = "wrongpassword"
    let registeredEmail = "alreadyregistereduser@email.com"
    let unregisteredEmail = "unregistered@email.com"
    let invalidEmail = "invalid@email"
    
    override func setUp() {
        super.setUp()
        restartApp()
    }
    
    func testHasLogoLabel() {
        let passwordTextField = grey_accessibilityID(AccesID.passwordTextField)
        EarlGrey.select(elementWithMatcher: passwordTextField)
            .assert(grey_sufficientlyVisible())
    }
    
    func testHasEmailTextField() {
        let emailTextField = grey_accessibilityID(AccesID.emailTextField)
        EarlGrey.select(elementWithMatcher: emailTextField)
            .assert(grey_sufficientlyVisible())
    }
    
    func testHasLoginButton() {
        let loginButton = grey_accessibilityID(AccesID.loginButton)
        EarlGrey.select(elementWithMatcher: loginButton)
            .assert(grey_sufficientlyVisible())
    }
    
    func testHasRegisterButton() {
        let registerButton = grey_accessibilityID(AccesID.registerButton)
        EarlGrey.select(elementWithMatcher: registerButton)
            .assert(grey_sufficientlyVisible())
    }
    
    func testRegisteringWithInvalidEmailDisplaysLocalisedError() {
        let localisedErrorMessage = localizedStringWith(key: "InvalidEmailError")
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccesID.toastLabel))
        let assertion = grey_text(localisedErrorMessage)
        let conditionName = "Wait for toast to appear with correct text"
        
        register(email: invalidEmail,
                 password: password,
                 confirmationPassword: password)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast appeared with correct text")
    }
    
    func testRegisteringWithInvalidPasswordDisplaysLocalisedError() {
        let email = createEmail(with: "\(#function)")
        let localisedErrorMessage = localizedStringWith(key: "InvalidPasswordError")
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccesID.toastLabel))
        let assertion = grey_text(localisedErrorMessage)
        let conditionName = "Wait for toast to appear with correct text"
        
        register(email: email,
                 password: password,
                 confirmationPassword: shortPassword)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast appeared with correct text")
    }
    
    func testRegisteringWithInvalidConfirmationPasswordDisplaysLocalisedError() {
        let email = createEmail(with: "\(#function)")
        let localisedErrorMessage = localizedStringWith(key: "InvalidPasswordError")
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccesID.toastLabel))
        let assertion = grey_text(localisedErrorMessage)
        let conditionName = "Wait for toast to appear with correct text"
        
        register(email: email,
                 password: password,
                 confirmationPassword: shortPassword)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast appeared with correct text")
    }
    
    func testRegisteringWithDifferentPasswordsDisplaysLocalisedError() {
        let email = createEmail(with: "\(#function)")
        let localisedErrorMessage = localizedStringWith(key: "PasswordMismatchError")
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccesID.toastLabel))
        let assertion = grey_text(localisedErrorMessage)
        let conditionName = "Wait for toast to appear with correct text"
        
        register(email: email,
                 password: password,
                 confirmationPassword: differentPassword)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast appeared with correct text")
    }
    
    func testRegisteringWithUsedEmailDisplaysFirebaseError() {
        let firebaseErrorMessage = "The email address is already in use by another account."
        let assertion = grey_text(firebaseErrorMessage)
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccesID.toastLabel))
        let conditionName = "Wait for toast to appear"
        
        register(email: registeredEmail,
                 password: password,
                 confirmationPassword: password)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast appeared with correct text")
    }
    
    func testLoginWithInvalidEmailDisplaysLocalisedError() {
        let localisedErrorMessage = localizedStringWith(key: "InvalidEmailError")
        let assertion = grey_text(localisedErrorMessage)
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccesID.toastLabel))
        let conditionName = "Wait for toast to appear"
        
        login(email: invalidEmail,
              password: password)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast appeared with correct text")
    }
    
    func testLoginWithInvalidPasswordDisplaysLocalisedError() {
        let localisedErrorMessage = localizedStringWith(key: "InvalidPasswordError")
        let assertion = grey_text(localisedErrorMessage)
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccesID.toastLabel))
        let conditionName = "Wait for toast to appear"
        
        login(email: registeredEmail,
              password: shortPassword)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast appeared with correct text")
    }
    
    func testLoginWithUnregisteredEmailDisplaysFirebaseError() {
        // swiftlint:disable:next line_length
        let firebaseErrorMessage = "There is no user record corresponding to this identifier. The user may have been deleted."
        let assertion = grey_text(firebaseErrorMessage)
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccesID.toastLabel))
        let conditionName = "Wait for toast to appear"
        
        login(email: unregisteredEmail,
              password: password)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast appeared with correct text")
    }
    
    func testLoginWithIncorrectPasswordDisplaysFirebaseError() {
        let firebaseErrorMessage = "The password is invalid or the user does not have a password."
        let assertion = grey_text(firebaseErrorMessage)
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccesID.toastLabel))
        let conditionName = "Wait for toast to appear"
        
        login(email: registeredEmail,
              password: wrongPassword)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast appeared with correct text")
    }
    
    func waitForSuccess(of assertion: GREYMatcher,
                        with element: GREYElementInteraction,
                        conditionName: String ) -> Bool {
        var success = false
        
        GREYCondition(name: conditionName, block: { () -> Bool in
            
            let errorOrNil = UnsafeMutablePointer<NSError?>.allocate(capacity: 1)
            errorOrNil.initialize(to: nil)
            
            element.assert(with: assertion, error: errorOrNil)
            
            success = errorOrNil.pointee == nil
            errorOrNil.deinitialize()
            errorOrNil.deallocate(capacity: 1)
            
            return success
        }).wait(withTimeout: 3.0)
        
        return success
    }
    
    func restartApp() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.resetAppToWelcomeScreen()
    }
    
    func localizedStringWith(key: String) -> String {
        return NSLocalizedString(key,
                                 bundle: Bundle(for: WelcomeScreenTests.self),
                                 comment: "")
    }
}

extension XCTest {
    
    func login(email: String, password: String) {
        let emailTextField = grey_accessibilityID(AccesID.emailTextField)
        let passwordTextField = grey_accessibilityID(AccesID.passwordTextField)
        let loginButton = grey_accessibilityID(AccesID.loginButton)
        
        EarlGrey.select(elementWithMatcher: emailTextField)
            .perform(grey_tap()).perform(grey_typeText(email))
        EarlGrey.select(elementWithMatcher: passwordTextField)
            .perform(grey_tap()).perform(grey_typeText(password))
        EarlGrey.select(elementWithMatcher: loginButton).perform(grey_tap())
    }
    
    func register(email: String, password: String, confirmationPassword: String) {
        let emailTextField = grey_accessibilityID(AccesID.emailTextField)
        let passwordTextField = grey_accessibilityID(AccesID.passwordTextField)
        let confirmPasswordTextField = grey_accessibilityID(AccesID.confirmPasswordTextField)
        let registerButton = grey_accessibilityID(AccesID.registerButton)
        
        EarlGrey.select(elementWithMatcher: emailTextField)
            .perform(grey_tap()).perform(grey_typeText(email))
        
        EarlGrey.select(elementWithMatcher: passwordTextField)
            .perform(grey_tap()).perform(grey_typeText(password))
        
        EarlGrey.select(elementWithMatcher: registerButton).perform(grey_tap())
        
        EarlGrey.select(elementWithMatcher: confirmPasswordTextField)
            .perform(grey_tap()).perform(grey_typeText(confirmationPassword))
        
        EarlGrey.select(elementWithMatcher: registerButton).perform(grey_tap())
    }
}
