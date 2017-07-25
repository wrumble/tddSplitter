//
//  BillTests.swift
//  BillTests
//
//  Created by Wayne Rumble on 21/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
import Firebase
@testable import Splitter
// swiftlint:disable trailing_whitespace
// swiftlint:disable unused_closure_parameter

class BillTests: XCTestCase {
    let databaseReference = Database.database().reference()
    let storageRefererence = Storage.storage().reference()
    let firebaseData = FirebaseData()
    let firebaseStorage = FirebaseStorage()
    
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
        storageRefererence.child("BillImages").child("testBillID.jpg").delete()
    }
    func testCanUploadBillImage() {
        var testSuccess = true
        let requestExpectation = expectation(description: "Uploads receipt image")
        let imageData = UIImageJPEGRepresentation(UIImage(named: "receipt1")!, 0.8)!
        firebaseStorage.uploadImage(billId: "testBillID.jpg", imageData: imageData, completion: { imageURL in
            if let imageURL = imageURL {
                print(imageURL)
                testSuccess = true
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertTrue(testSuccess)
        }
    }
    
    func testCanCreateNewBill() {
        var testSuccess = false
        let requestExpectation = expectation(description: "Creates a bill")
        let bill = Bill(name: "Bob Ross",
                        date: Date().currentDateTimeAsString(),
                        location: "MacDonalds",
                        imageURL: "https://testurl.com")
        
        firebaseData.createBill(bill, completion: { (error, result) in
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
        removeTestBill(withID: bill.id)
    }
    
    func testCanRequestBillWithId() {
        let bill = Bill(name: "Bob Ross",
                        date: Date().currentDateTimeAsString(),
                        location: "MacDonalds",
                        imageURL: "https://testurl.com")
        addBillToFirebase(bill)
        
        var resultID = String()
        let requestExpectation = expectation(description: "Request a bill")
        firebaseData.findBill(withID: bill.id, completion: { bill in
            if let bill = bill {
                resultID = bill.id
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertEqual(resultID, bill.id)
        }
        removeTestBill(withID: bill.id)
    }
    
    func testCanRemoveBillFromFirebase() {
        let bill = Bill(name: "Bob Ross",
                        date: Date().currentDateTimeAsString(),
                        location: "MacDonalds",
                        imageURL: "https://testurl.com")
        addBillToFirebase(bill)
        
        var testSuccess = false
        let requestExpectation = expectation(description: "Remove a bill")
        firebaseData.removeBill(withID: bill.id, completion: { (error, result) in
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
    }
    
    func addBillToFirebase(_ bill: Bill) {
        let requestExpectation = expectation(description: "Creates a bill")
        firebaseData.createBill(bill, completion: { (error, result) in
            if let result = result {
                print(result)
            } else {
                print(error!)
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 5)
    }
    
    func removeTestBill(withID id: String) {
        databaseReference.child("Bills").child(id).removeValue()
    }
}
