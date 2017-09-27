//
//  File.swift
//  EarlGreyWelcomeScreenTests
//
//  Created by Wayne Rumble on 15/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
import EarlGrey
@testable import Splitter

// swiftlint:disable type_body_length
class EarlGreyWelcomeScreenTests: XCTestCase {
    
    let userRepository = UserRepository()
    
    override func setUp() {
        super.setUp()
        restartApp()
    }
    
    func testHasLogoLabel() {
        let passwordTextField = grey_accessibilityID(AccessID.passwordTextField)
        EarlGrey.select(elementWithMatcher: passwordTextField)
            .assert(grey_sufficientlyVisible())
    }
    
    func testHasEmailTextField() {
        let emailTextField = grey_accessibilityID(AccessID.emailTextField)
        EarlGrey.select(elementWithMatcher: emailTextField)
            .assert(grey_sufficientlyVisible())
    }
    
    func testHasLoginButton() {
        let loginButton = grey_accessibilityID(AccessID.loginButton)
        EarlGrey.select(elementWithMatcher: loginButton)
            .assert(grey_sufficientlyVisible())
    }
    
    func testHasRegisterButton() {
        let registerButton = grey_accessibilityID(AccessID.registerButton)
        EarlGrey.select(elementWithMatcher: registerButton)
            .assert(grey_sufficientlyVisible())
    }
    
    func testRegisteringWithInvalidEmailDisplaysLocalisedError() {
        let localisedErrorMessage = localizedStringWith(key: "InvalidEmailError")
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccesID.toastLabel))
        let assertion = grey_text(localisedErrorMessage)
        let conditionName = "Wait for toast to appear with correct text"
        let invalidEmailUser = userRepository.getInvalidEmailUser()
        
        register(invalidEmailUser)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast did not appear with correct text")
    }
    
    func testRegisteringWithInvalidPasswordDisplaysLocalisedError() {
        let localisedErrorMessage = localizedStringWith(key: "InvalidPasswordError")
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.toastLabel))
        let assertion = grey_text(localisedErrorMessage)
        let conditionName = "Wait for toast to appear with correct text"
        let tooShortPasswordUser = userRepository.getTooShortPasswordUser()
        
        register(tooShortPasswordUser)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast did not appear with correct text")
    }
    
    func testRegisteringWithInvalidConfirmationPasswordDisplaysLocalisedError() {
        let localisedErrorMessage = localizedStringWith(key: "InvalidPasswordError")
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.toastLabel))
        let assertion = grey_text(localisedErrorMessage)
        let conditionName = "Wait for toast to appear with correct text"
        let tooShortConfirmationPasswordUser = userRepository.getTooShortConfirmationPasswordUser()
        
        register(tooShortConfirmationPasswordUser)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast did not appear with correct text")
    }
    
    func testRegisteringWithDifferentPasswordsDisplaysLocalisedError() {
        let localisedErrorMessage = localizedStringWith(key: "PasswordMismatchError")
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.toastLabel))
        let assertion = grey_text(localisedErrorMessage)
        let conditionName = "Wait for toast to appear with correct text"
        let differentConfirmationPasswordUser = userRepository.getDifferentConfirmationPasswordUser()
        
        register(differentConfirmationPasswordUser)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast did not appear with correct text")
    }
    
    func testRegisteringWithUsedEmailDisplaysFirebaseError() {
        let firebaseErrorMessage = "The email address is already in use by another account."
        let assertion = grey_text(firebaseErrorMessage)
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.toastLabel))
        let conditionName = "Wait for toast to appear"
        let usedEmailUser = userRepository.getUsedEmailUser()
        
        register(usedEmailUser)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast did not appear with correct text")
    }
    
    func testLoginWithInvalidEmailDisplaysLocalisedError() {
        let localisedErrorMessage = localizedStringWith(key: "InvalidEmailError")
        let assertion = grey_text(localisedErrorMessage)
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.toastLabel))
        let conditionName = "Wait for toast to appear"
        let invalidEmailUser = userRepository.getInvalidEmailUser()
        
        login(invalidEmailUser)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast did not appear with correct text")
    }
    
    func testLoginWithInvalidPasswordDisplaysLocalisedError() {
        let localisedErrorMessage = localizedStringWith(key: "InvalidPasswordError")
        let assertion = grey_text(localisedErrorMessage)
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.toastLabel))
        let conditionName = "Wait for toast to appear"
        let shortPasswordUser = userRepository.getTooShortPasswordUser()
        
        login(shortPasswordUser)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast did not appear with correct text")
    }
    
    func testLoginWithUnregisteredEmailDisplaysFirebaseError() {
        // swiftlint:disable:next line_length
        let firebaseErrorMessage = "There is no user record corresponding to this identifier. The user may have been deleted."
        let assertion = grey_text(firebaseErrorMessage)
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.toastLabel))
        let conditionName = "Wait for toast to appear"
        let unregisteredEmailUser = userRepository.getUnregisteredEmailUser()
        
        login(unregisteredEmailUser)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast did not appear with correct text")
    }
    
    func testLoginWithIncorrectPasswordDisplaysFirebaseError() {
        let firebaseErrorMessage = "The password is invalid or the user does not have a password."
        let assertion = grey_text(firebaseErrorMessage)
        let toastLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.toastLabel))
        let conditionName = "Wait for toast to appear"
        let incorrectPasswordUser = userRepository.getIncorrectPasswordUser()
        
        login(incorrectPasswordUser)
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: toastLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully, reason: "Toast did not appear with correct text")
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
                                 bundle: Bundle(for: EarlGreyWelcomeScreenTests.self),
                                 comment: "")
    }
}

extension XCTest {
    
    func login(_ user: TestUser) {
        let emailTextField = grey_accessibilityID(AccessID.emailTextField)
        let passwordTextField = grey_accessibilityID(AccessID.passwordTextField)
        let loginButton = grey_accessibilityID(AccesID.loginButton)
        
        EarlGrey.select(elementWithMatcher: emailTextField)
            .perform(grey_tap()).perform(grey_typeText(user.email))
        EarlGrey.select(elementWithMatcher: passwordTextField)
            .perform(grey_tap()).perform(grey_typeText(user.password))
        EarlGrey.select(elementWithMatcher: loginButton).perform(grey_tap())
    }
    
    func register(_ user: TestUser) {
        let emailTextField = grey_accessibilityID(AccessID.emailTextField)
        let passwordTextField = grey_accessibilityID(AccessID.passwordTextField)
        let confirmPasswordTextField = grey_accessibilityID(AccessID.confirmPasswordTextField)
        let registerButton = grey_accessibilityID(AccessID.registerButton)
        
        EarlGrey.select(elementWithMatcher: emailTextField)
            .perform(grey_tap()).perform(grey_typeText(user.email))
        
        EarlGrey.select(elementWithMatcher: passwordTextField)
            .perform(grey_tap()).perform(grey_typeText(user.password))
        
        EarlGrey.select(elementWithMatcher: registerButton).perform(grey_tap())
        
        EarlGrey.select(elementWithMatcher: confirmPasswordTextField)
            .perform(grey_tap()).perform(grey_typeText(user.confirmationPassword))
        
        EarlGrey.select(elementWithMatcher: registerButton).perform(grey_tap())
    }
}
