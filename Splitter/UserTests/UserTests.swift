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
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCanCreateUser() {
        var testSuccess = true
        var user = SplitterUser(name: "Bob Ross", email: "test@email.com")
        let requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.createUser(email: user.email, password: "password", completion: { (error, firebaseUser) in
            if let firebaseUser = firebaseUser {
                user.id = firebaseUser.uid
                print(user.id)
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
    
    func removeUser(_ user: User) {
        user.delete(completion: { error in
            if let error = error {
                print(error)
            }
        })
    }
}
