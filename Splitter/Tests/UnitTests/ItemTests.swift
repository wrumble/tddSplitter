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

class ItemTests: XCTestCase {
    
    let databaseReference = Database.database().reference()
    let firebaseData = FirebaseData()
    
    func testCanCreateNewItem() {
        var testSuccess = false
        let billID = addBillToFirebase()
        let requestExpectation = expectation(description: "Creates an Item")
        let item = Item(name: "Baked Beans",
                        price: "3.50",
                        billID: billID)
        
        firebaseData.createItem(item,
                                completion: { (error) in
            if let error = error {
                XCTFail(String(describing: error))
            } else {
                testSuccess = true
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { (_) in
            XCTAssertTrue(testSuccess)
        }
        removeTestBill(withID: billID)
    }
    
    func testCanRequestItem() {
        var resultID = String()
        let billID = addBillToFirebase()
        let item = addItemToBill(withID: billID)
        let requestExpectation = expectation(description: "Request a bill")
        
        firebaseData.findItem(item, completion: { item in
            if let item = item {
                resultID = item.id
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 5) { _ in
            XCTAssertEqual(resultID, item.id)
        }
        removeTestBill(withID: billID)
    }
    
    func testCanRemoveItemFromBill() {
        var testSuccess = false
        let billID = addBillToFirebase()
        let item = addItemToBill(withID: billID)
        let requestExpectation = expectation(description: "Remove a bill")
        
        firebaseData.removeItem(item,
                                completion: { (error) in
            if let error = error {
                XCTFail(String(describing: error))
            } else {
                testSuccess = true
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { _ in
            XCTAssertTrue(testSuccess)
        }
        removeTestBill(withID: billID)
    }
    
    func addBillToFirebase() -> String {
        let bill = Bill(id: "testBillID",
                        userID: "testUserID",
                        name: "Bob Ross",
                        location: "MacDonalds",
                        imageURL: "https://testurl.com",
                        items: nil)
        
        weak var requestExpectation = expectation(description: "Creates a bill")
        firebaseData.createBill(bill, completion: { (error) in
            if let error = error {
                print(error)
            }
            requestExpectation?.fulfill()
        })
        waitForExpectations(timeout: 5)
        
        return bill.id
    }
    
    func addItemToBill(withID billID: String) -> Item {
        let item = Item(name: "Baked Beans",
                        price: "3.50",
                        billID: billID)
        
        weak var requestExpectation = expectation(description: "Creates an item")
        firebaseData.createItem(item, completion: { (error) in
            if let error = error {
                XCTFail(String(describing: error))
            }
            requestExpectation?.fulfill()
        })
        return item
    }
    
    func removeTestBill(withID id: String) {
        databaseReference.child("Bills").child(id).removeValue()
    }
}
