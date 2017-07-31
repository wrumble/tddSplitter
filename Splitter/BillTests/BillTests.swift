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
        var testSuccess = false
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
                        imageURL: "https://testurl.com",
                        items: nil)
        
        firebaseData.createBill(bill, completion: { (error) in
            if let error = error {
                XCTFail(String(describing: error))
            } else {
                testSuccess = true
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertTrue(testSuccess)
        }
        removeTestBill(withID: bill.id)
    }
    
    func testCanRequestBillWithId() {
        var resultID = String()
        let id = addBillToFirebase()//FIXME naming
        let requestExpectation = expectation(description: "Request a bill")
        
        firebaseData.findBill(with: id, completion: { bill in
            if let bill = bill {
                resultID = bill.id
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertEqual(resultID, id)
        }
        removeTestBill(withID: id)
    }
    
    func testCanRemoveBillFromFirebase() {
        var testSuccess = false
        let id = addBillToFirebase()//FIXME naming
        let requestExpectation = expectation(description: "Remove a bill")
        
        firebaseData.removeBill(with: id, completion: { (error) in
            if let error = error {
                XCTFail(String(describing: error))
            } else {
                testSuccess = true
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertTrue(testSuccess)
        }
    }
    
    func addBillToFirebase() -> String { //FIXME naming
        let bill = Bill(name: "Bob Ross",
                        date: Date().currentDateTimeAsString(),
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
    
    func removeTestBill(withID id: String) {
        databaseReference.child("Bills").child(id).removeValue()
    }
}
