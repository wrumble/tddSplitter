//
//  LoginRegisterUITests.swift
//  LoginRegisterUITests
//
//  Created by Wayne Rumble on 31/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
@testable import Splitter

class LoginRegisterUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        app.launch()
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasEmailTextField() {
        let emailTextField = app.textFields["Email"]
        
        XCTAssertTrue(emailTextField.isHittable)
    }
    
    func testHasPasswordTextField() {
        let emailTextField = app.textFields["Password"]
        
        XCTAssertTrue(emailTextField.isHittable)
    }
    
    func testHasLoginButton() {
        let loginButton = app.buttons["Login"]
        
        XCTAssertTrue(loginButton.isHittable)
    }
    
    func testHasRegisterButton() {
        let registerButton = app.buttons["Register"]
        
        XCTAssertTrue(registerButton.isHittable)
    }
    
    func testTappingRegisterButtonHidesLoginButton() {
        let loginButton = app.buttons["Login"]
        let registerButton = app.buttons["Register"]
        
        XCTAssertTrue(loginButton.exists)
        
        registerButton.tap()

        XCTAssertFalse(loginButton.exists)
    }
    
    func testTappingRegisterButtonShowsConfirmPasswordTextField() {
        let registerButton = app.buttons["Register"]
        let confirmPasswordTextField = app.textFields["ConfirmPassword"]
        
        XCTAssertFalse(confirmPasswordTextField.exists)
        
        registerButton.tap()
        
        XCTAssertTrue(confirmPasswordTextField.exists)
    }
}
