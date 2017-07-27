//
//  ItemTests.swift
//  ItemTests
//
//  Created by Wayne Rumble on 27/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
import Firebase
@testable import Splitter
// swiftlint:disable unused_closure_parameter

class ItemTests: XCTestCase {
    
    let databaseReference = Database.database().reference()
    let firebaseData = FirebaseData()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCanCreateNewItem() {
        var testSuccess = false
        let billID = addBillToFirebase()
        let requestExpectation = expectation(description: "Creates an Item")
        let item = Item(name: "Baked Beans",
                        price: 3.50,
                        billID: billID)
        
        firebaseData.createItem(item, completion: { (error, result) in
            if let result = result {
                print(result)
                testSuccess = true
            } else {
                XCTFail(String(describing: error!))
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertTrue(testSuccess)
        }
        removeTestBill(withID: billID)
    }
    
    func addBillToFirebase() -> String { //FIXME naming
        let bill = Bill(name: "Bob Ross",
                        date: Date().currentDateTimeAsString(),
                        location: "MacDonalds",
                        imageURL: "https://testurl.com",
                        items: nil)
        
        weak var requestExpectation = expectation(description: "Creates a bill")
        firebaseData.createBill(bill, completion: { (error, result) in
            if let result = result {
                print(result)
            } else {
                print(error!)
            }
            requestExpectation?.fulfill()
        })
        waitForExpectations(timeout: 5)
        
        return bill.id
    }
    
    func removeTestBill(withID id: String) {
        databaseReference.child("Bills").child(id).removeValue()
    }
}

