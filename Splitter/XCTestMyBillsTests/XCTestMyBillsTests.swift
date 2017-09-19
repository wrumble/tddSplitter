//
//  XCTestMyBillsTests.swift
//  XCTestMyBillsTests
//
//  Created by Wayne Rumble on 19/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest

class XCTestMyBillsTests: XCTestCase {
    
    let app = XCUIApplication()
    let registeredUserEmail = "alreadyregistereduser@email.com"
    let password = "password"
    
    override func setUp() {
        super.setUp()
        app.launch()
    }
    
    func testDeleteButtonNotVisibleWhenThereAreNoBills() {
        waitForMyBillsViewController {
            let deleteButton = self.app.buttons[AccessID.deleteButton]
            
            XCTAssertFalse(deleteButton.exists)
        }
    }
    
    func testAddBillButtonSeguesToNewBillViewController() {
        waitForMyBillsViewController {
            let addButton = self.app.buttons[AccessID.addButton]
            let newBillTitleText = NSLocalizedString("NewBillViewControllerTitle",
                                                     bundle: Bundle(for: XCTestMyBillsTests.self),
                                                     comment: "")
            let newBillViewControllerTitle = self.app.staticTexts[newBillTitleText]
            let newBillTitleExists = NSPredicate(format: "exists == 1")
            
            addButton.tap()
            
            self.expectation(for: newBillTitleExists, evaluatedWith: newBillViewControllerTitle, handler: nil)
            self.waitForExpectations(timeout: 10)
            
            XCTAssertTrue(newBillViewControllerTitle.exists)
        }
    }
    
    func login(email: String, password: String) {
        let emailTextField = app.textFields[AccessID.emailTextField]
        let passwordTextField = app.secureTextFields[AccessID.passwordTextField]
        let loginButton = app.buttons[AccessID.loginButton]
        
        emailTextField.tap()
        emailTextField.typeText(email)
        passwordTextField.tap()
        passwordTextField.typeText(password)
        loginButton.tap()
    }
    
    func waitForMyBillsViewController(completion: @escaping () -> Void) {
        let myBillsTitleText = NSLocalizedString("MyBillsViewControllerTitle",
                                                 bundle: Bundle(for: XCTestMyBillsTests.self),
                                                 comment: "")
        let myBillsViewControllerTitle = app.staticTexts[myBillsTitleText]
        let myBillsTitleExists = NSPredicate(format: "exists == 1")
        
        login(email: registeredUserEmail,
              password: password)
        
        expectation(for: myBillsTitleExists, evaluatedWith: myBillsViewControllerTitle, handler: nil)
        waitForExpectations(timeout: 10, handler: { _ in
            completion()
        })
    }
}
