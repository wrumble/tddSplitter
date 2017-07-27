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
// swiftlint:disable unused_closure_parameter

class UserTests: XCTestCase {
    
    let databaseReference = Database.database().reference()
    let firebaseData = FirebaseData()
    var user: User?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCanCreateUser() {
        var testSuccess = false
        let user = SplitterUser(name: "Bob Ross", email: "test@email.com")
        let requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.createUser(email: user.email, password: "password", completion: { (error, firebaseUser) in
            if let firebaseUser = firebaseUser {
                testSuccess = true
                self.removeUser(firebaseUser)
            } else {
                XCTFail(String(describing: error!))
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertTrue(testSuccess)
        }
    }
    
    func testUserCanLoginUser() {
        createUser()
        var testSuccess = false
        let requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.signInUser(email: "test@email.com", password: "password", completion: { (error, firebaseUser) in
            if let firebaseUser = firebaseUser {
                testSuccess = true
                self.removeUser(firebaseUser)
            } else {
                XCTFail(String(describing: error!))
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertTrue(testSuccess)
        }
        
    }
    
    func testUserCanLogout() {
        createUser()
        var testSuccess = false
        let requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.signOutUser(completion: { (signedOut) in
            testSuccess = signedOut
            if self.user != nil {
                self.removeUser(self.user!)
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertTrue(testSuccess)
        }
    }
    
    func createUser() {
        let user = SplitterUser(name: "Bob Ross", email: "test@email.com")
        weak var requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.createUser(email: user.email, password: "password", completion: { (error, firebaseUser) in
            if let error = error {
                print(error)
            } else {
                self.user = firebaseUser
            }
            requestExpectation?.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
    
    func removeUser(_ user: User) {
        user.delete(completion: { error in
            if let error = error {
                print(error)
            }
        })
    }
}
