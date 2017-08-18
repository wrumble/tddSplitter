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
    
    var createdUserEmails = [String]()
    
    let databaseReference = Database.database().reference()
    let firebaseData = FirebaseData()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        createdUserEmails.forEach { email in
            self.removeUser(with: email)
        }
    }
    
    func testCanCreateUser() {
        var testSuccess = false
        let email = createEmail(with: "\(#function)")
        createdUserEmails.append(email)
        
        let requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.createUser(email: email,
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
        let email = createEmail(with: "\(#function)")
        createUser(with: email)
        createdUserEmails.append(email)
        
        var testSuccess = false
        let requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.signInUser(email: email,
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
        let email = createEmail(with: "\(#function)")
        createUser(with: email)
        createdUserEmails.append(email)
        
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
    
    func createUser(with email: String) {
        weak var requestExpectation = expectation(description: "Creates a user")
        
        firebaseData.createUser(email: email,
                                password: "password",
                                completion: { (error, _ ) in
            if let error = error {
                print(error)
            }
            requestExpectation?.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
    
    func createEmail(with functionName: String) -> String {
        let brackets = CharacterSet(charactersIn: "()")
        let cleanedFunctionName = functionName.components(separatedBy: brackets).joined()
        
        return "\(cleanedFunctionName)@email.com"
    }
    
    func removeUser(with email: String) {
        print(email)
        Auth.auth().signIn(withEmail: email, password: "password", completion: { (user, _) in
            if user != nil {
                if let signedInUser = Auth.auth().currentUser {
                    signedInUser.delete()
                }
            }
        })
    }
}
