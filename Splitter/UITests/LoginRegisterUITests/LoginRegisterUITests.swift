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
}
