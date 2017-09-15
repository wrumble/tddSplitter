//
//  UserTests.swift
//  UserTests
//
//  Created by Wayne Rumble on 27/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
import Firebase
@testable import Splitter

class UserTests: XCTestCase {
    
    var createdUserEmail: String?
    
    let databaseReference = Database.database().reference()
    let firebaseData = FirebaseData()
    
    let firebaseHelper = FirebaseTestHelper()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        if let email = createdUserEmail {
            firebaseHelper.removeUser(with: email)
        }
        super.tearDown()
    }
    
    func testCanCreateUser() {
        var testSuccess = false
        createdUserEmail = createEmail(with: "\(#function)")
        
        let requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.createUser(email: createdUserEmail!,
                                password: "password",
                                completion: { (error, splitterUser) in
            if splitterUser != nil {
                testSuccess = true
            } else {
                XCTFail(String(describing: error!))
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { _ in
            XCTAssertTrue(testSuccess)
        }
    }
    
    func testUserCanLogin() {
        createdUserEmail = createEmail(with: "\(#function)")
        firebaseHelper.createUser(with: createdUserEmail!)
        
        var testSuccess = false
        let requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.signInUser(email: createdUserEmail!,
                                password: "password",
                                completion: { (error, splitterUser) in
            if splitterUser != nil {
                testSuccess = true
            } else {
                XCTFail(String(describing: error!))
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { _ in
            XCTAssertTrue(testSuccess)
        }
    }
    
    func testUserCanLogout() {
        createdUserEmail = createEmail(with: "\(#function)")
        firebaseHelper.createUser(with: createdUserEmail!)
        
        var testSuccess = false
        let requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.signOutUser(completion: { (signedOut) in
            testSuccess = signedOut
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { _ in
            XCTAssertTrue(testSuccess)
        }
    }
}
