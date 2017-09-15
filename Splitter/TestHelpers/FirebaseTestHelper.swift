//
//  FireBaseTestHelper.swift
//  Splitter
//
//  Created by Wayne Rumble on 23/08/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
import Firebase
@testable import Splitter

class FirebaseTestHelper: XCTestCase {
    
    func createUser(with email: String) {
        
        weak var requestExpectation = expectation(description: "Creates a user")

        Auth.auth().createUser(withEmail: email, password: "password", completion: { (_, _) in
            requestExpectation?.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
    
    func removeUser(with email: String) {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        Auth.auth().signIn(withEmail: email, password: "password", completion: { (user, _) in
            if user != nil {
                if let signedInUser = Auth.auth().currentUser {
                    signedInUser.delete()
                }
            }
        })
    }
}
