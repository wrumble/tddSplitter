//
//  EarlGreyNewBillTests.swift
//  EarlGreyNewBillTests
//
//  Created by Wayne Rumble on 21/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
import EarlGrey
@testable import Splitter

// swiftlint:disable line_length
class EarlGreyNewBillTests: XCTestCase {
    
    func testHasTitleLabel() {
        startAtNewBillVCWithUserID("No need yet")
        let assertion = grey_sufficientlyVisible()
        let titleLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.titleLabel))
        let conditionName = "Wait for NoBillsLabel to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: titleLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Delete Bill View Appeared")
        
    }
    
    func testHasBillNameTextField() {
        startAtNewBillVCWithUserID("No need yet")
        let assertion = grey_sufficientlyVisible()
        let billNameTextField = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.nameTextField))
        let conditionName = "Wait for name textfield to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: billNameTextField,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Name textfield appeared")
    }
    
    func testHasBillLocationTextField() {
        startAtNewBillVCWithUserID("No need yet")
        let assertion = grey_sufficientlyVisible()
        let billLocationTextField = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.locationTextField))
        let conditionName = "Wait for location textfield to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: billLocationTextField,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Location textfield appeared")
    }
    
    func testHasTakeCameraButton() {
        startAtNewBillVCWithUserID("No need yet")
        let assertion = grey_sufficientlyVisible()
        let cameraButton = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.cameraButton))
        let conditionName = "Wait for camera button to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: cameraButton,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Camera button appeared")
    }
    
    func testHasHomeButton() {
        startAtNewBillVCWithUserID("No need yet")
        let assertion = grey_sufficientlyVisible()
        let homeButton = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.homeButton))
        let conditionName = "Wait for home button to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: homeButton,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Home button appeared")
    }
    
    func testHasSaveButton() {
        startAtNewBillVCWithUserID("No need yet")
        let assertion = grey_sufficientlyVisible()
        let saveButton = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.saveButton))
        let conditionName = "Wait for save button to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: saveButton,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Save button appeared")
    }
    
    func testHasInstructionLabelButton() {
        startAtNewBillVCWithUserID("No need yet")
        let assertion = grey_sufficientlyVisible()
        let instructionLabel = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.instructionLabel))
        let conditionName = "Wait for instruction label to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: instructionLabel,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Instruction label appeared")
    }
    
    func testTappingCameraButtonOpensImagePickerController() {
        startAtNewBillVCWithUserID("No need yet")
        let cameraButton = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccesID.cameraButton))
        cameraButton.perform(grey_tap())
        let assertion = grey_sufficientlyVisible()
        let imagePicker = EarlGrey.select(elementWithMatcher: grey_accessibilityID(AccessID.imagePicker))
        let conditionName = "Wait for instruction label to appear"
        let appearedSuccesfully = waitForSuccess(of: assertion,
                                                 with: imagePicker,
                                                 conditionName: conditionName)
        
        GREYAssertTrue(appearedSuccesfully,
                       reason: "Instruction label appeared")
    }
    
//Helper methods
    
    func startAtNewBillVCWithUserID(_ userID: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.startAtNewBillVCWithUserID(userID)
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
