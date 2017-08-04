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
    
    let databaseReference = Database.database().reference()
    let firebaseData = FirebaseData()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCanCreateUser() {
        var testSuccess = false
        let requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.createUser(email: "CreateUser@email.com",
                                password: "password",
                                completion: { (error, splitterUser) in
            if splitterUser != nil {
                testSuccess = true
                self.removeUser()
            } else {
                XCTFail(String(describing: error!))
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { _ in
            XCTAssertTrue(testSuccess)
        }
    }
    
    func testUserCanLoginUser() {
        createUser()
        var testSuccess = false
        let requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.signInUser(email: "CreateUser@email.com",
                                password: "password",
                                completion: { (error, splitterUser) in
            if splitterUser != nil {
                testSuccess = true
                self.removeUser()
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
        createUser()
        var testSuccess = false
        let requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.signOutUser(completion: { (signedOut) in
            testSuccess = signedOut
            self.removeUser()
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { _ in
            XCTAssertTrue(testSuccess)
        }
    }
    
    func createUser() {
        weak var requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.createUser(email: "CreateUser@email.com",
                                password: "password",
                                completion: { (error, _ ) in
            if let error = error {
                print(error)
            }
            requestExpectation?.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
    
    func removeUser() {
        if let user = Auth.auth().currentUser {
            user.delete(completion: { error in
                if let error = error {
                    print(error)
                }
            })
        }
    }
}
