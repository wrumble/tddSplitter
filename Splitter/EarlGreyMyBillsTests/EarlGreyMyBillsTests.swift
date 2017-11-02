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
    
    let userRepository = UserRepository()
    let registeredUserEmail = "alreadyregistereduser@email.com"
    let userWithOneBillEmail = "userwithonebill@email.com"
    
    func testHasTitleLabel() {
        startAtMyBillsViewControllerWith(email: registeredUserEmail)
        let assertion = grey_sufficientlyVisible()
        let titleLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.titleLabel))
        let conditionName = "Wait for NoBillsLabel to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: titleLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Delete Bill View Appeared")

    }
    
    func testHasAddBillButton() {
        startAtMyBillsViewControllerWith(email: registeredUserEmail)
        let assertion = grey_sufficientlyVisible()
        let addButton = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.addButton))
        let conditionName = "Wait for add bills button to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: addButton,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Add bill button Appeared")
    }
    
    func testHasLogoutBillButton() {
        startAtMyBillsViewControllerWith(email: registeredUserEmail)
        let assertion = grey_sufficientlyVisible()
        let addButton = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.logoutButton))
        let conditionName = "Wait for add bills button to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: addButton,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Add bill button Appeared")
    }
    
    func testDeleteButtonNotVisibleWhenThereAreNoBills() {
        startAtMyBillsViewControllerWith(email: registeredUserEmail)

        let deleteButton = grey_accessibilityID(AccessID.deleteButton)
        var error: NSError?
        
        EarlGrey.select(elementWithMatcher: deleteButton)
                .assert(grey_sufficientlyVisible(),
                    error: &error)
        GREYAssertTrue((error != nil),
                       reason: "Delete button is visible")
    }
    
    func testDeleteButtonIsVisibleWhenThereAreBills() {
        startAtMyBillsViewControllerWith(email: userWithOneBillEmail)
        
        let deleteButton = grey_accessibilityID(AccessID.deleteButton)
        var error: NSError?
        
        EarlGrey.select(elementWithMatcher: deleteButton)
                .assert(grey_sufficientlyVisible(),
                    error: &error)
        GREYAssertFalse((error != nil),
                       reason: "Delete button not visible")
    }
    
    func testShowsUsersBills() {
        startAtMyBillsViewControllerWith(email: userWithOneBillEmail)
        let assertion = grey_sufficientlyVisible()
        let usersBill = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.carouselView))
        let conditionName = "Wait for Bill View to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: usersBill,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Users Bill View Appeared")
    }
    
    func testShowsNoBillsMessageWhenUserHasNoBills() {
        startAtMyBillsViewControllerWith(email: registeredUserEmail)
        
        let assertion = grey_sufficientlyVisible()
        let noBillsLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.instructionLabel))
        let conditionName = "Wait for NoBillsLabel to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: noBillsLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Label did not appear")
    }
    
    func testNoBillsLabelNotVisibleWhenUserHasBills() {
        startAtMyBillsViewControllerWith(email: userWithOneBillEmail)
        
        let instructionLabel = grey_accessibilityID(AccessID.instructionLabel)
        var error: NSError?
        
        EarlGrey.select(elementWithMatcher: instructionLabel)
                .assert(grey_sufficientlyVisible(),
                    error: &error)
        GREYAssertTrue((error != nil),
                       reason: "Label is visible")
    }
    
    func testAddBillButtonSeguesToNewBillViewController() {
        startAtMyBillsViewControllerWith(email: registeredUserEmail)
        let addButton = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.addButton))
        let newBillTitleText = localizedStringWith(key: "NewBillViewControllerTitle")
        let assertion = grey_text(newBillTitleText)
        let conditionName = "Wait for label to appear"
        
        addButton.perform(grey_tap())
        
        let titleLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.titleLabel))
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: titleLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Did not segue")
    }
    
    func testLogoutButtonSeguesToWelcomeScreenViewController() {
        startAtMyBillsViewControllerWith(email: registeredUserEmail)
        let logoutButton = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.logoutButton))
        let welcomeScreenLogoText = localizedStringWith(key: "SplitterTitleLogoText")
        let assertion = grey_text(welcomeScreenLogoText)
        let conditionName = "Wait for label to appear"

        logoutButton.perform(grey_tap())

        let titleLogoLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.titleLogoLabel))
        
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: titleLogoLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Did not segue")
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
}
