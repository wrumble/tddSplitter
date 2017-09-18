//
//  EarlGreyMyBillsTests.swift
//  EarlGreyMyBillsTests
//
//  Created by Wayne Rumble on 15/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
import EarlGrey
@testable import Splitter

// swiftlint:disable type_body_length
class EarlGreyMyBillsTests: XCTestCase {
    
    let registeredUserEmail = "alreadyregistereduser@email.com"
    let userWithOneBillEmail = "userwithonebill@email.com"
    
    func testHasTitleLabel() {
        startAtMyBillsViewControllerWith(email: registeredUserEmail)
        let titleLabel = grey_accessibilityID(AccessID.titleLabel)
        EarlGrey.select(elementWithMatcher: titleLabel)
            .assert(grey_sufficientlyVisible())
    }
    
    func testHasAddBillButton() {
        startAtMyBillsViewControllerWith(email: registeredUserEmail)
        let addbutton = grey_accessibilityID(AccessID.addButton)
        EarlGrey.select(elementWithMatcher: addbutton)
            .assert(grey_sufficientlyVisible())
    }
    
    func testHasDeleteBillButton() {
        startAtMyBillsViewControllerWith(email: registeredUserEmail)
        let deleteButton = grey_accessibilityID(AccessID.deleteButton)
        EarlGrey.select(elementWithMatcher: deleteButton)
            .assert(grey_sufficientlyVisible())
    }
    
    func testShowsUsersOneBill() {
        startAtMyBillsViewControllerWith(email: userWithOneBillEmail)
        let usersBill = grey_accessibilityID(AccessID.billView)
        let assertionText = "TestBill1"
        EarlGrey.select(elementWithMatcher: usersBill)
            .assert(grey_text(assertionText))

    }
    
    func startAtMyBillsViewControllerWith(email: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.startAtMyBillsVCWithUserEmail(email)
    }
    
    func localizedStringWith(key: String) -> String {
        return NSLocalizedString(key,
                                 bundle: Bundle(for: EarlGreyMyBillsTests.self),
                                 comment: "")
    }
    
    func login(email: String, password: String) {
        let emailTextField = grey_accessibilityID(AccessID.emailTextField)
        let passwordTextField = grey_accessibilityID(AccessID.passwordTextField)
        let loginButton = grey_accessibilityID(AccessID.loginButton)
        
        EarlGrey.select(elementWithMatcher: emailTextField)
            .perform(grey_tap()).perform(grey_typeText(email))
        EarlGrey.select(elementWithMatcher: passwordTextField)
            .perform(grey_tap()).perform(grey_typeText(password))
        EarlGrey.select(elementWithMatcher: loginButton).perform(grey_tap())
    }
}
