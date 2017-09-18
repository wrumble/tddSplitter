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
    
    override func setUp() {
        super.setUp()
        startAtMyBillsViewController()
    }
    
    func testHasTitleLabel() {
        let titleLabel = grey_accessibilityID(AccessID.titleLabel)
        EarlGrey.select(elementWithMatcher: titleLabel)
            .assert(grey_sufficientlyVisible())
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
    
    func startAtMyBillsViewController() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.startAtMyBillsViewController()
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
