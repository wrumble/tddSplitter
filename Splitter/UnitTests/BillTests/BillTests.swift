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

class BillTests: XCTestCase {
    let databaseReference = Database.database().reference()
    let storageRefererence = Storage.storage().reference()
    let firebaseData = FirebaseData()
    let firebaseStorage = FirebaseStorage()

    func testCanUploadBillImage() {
        var testSuccess = false
        let requestExpectation = expectation(description: "Uploads receipt image")
        let imageData = UIImageJPEGRepresentation(UIImage(named: "receipt1")!, 0.8)!
        
        firebaseStorage.uploadImage(billId: "testBillID.jpg",
                                    imageData: imageData,
                                    completion: { imageURL in
            if let imageURL = imageURL {
                print(imageURL)
                testSuccess = true
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { _ in
            XCTAssertTrue(testSuccess)
        }
        storageRefererence.child("BillImages").child("testBillID.jpg").delete()
    }
    
    func testCanCreateNewBill() {
        var testSuccess = false
        let requestExpectation = expectation(description: "Creates a bill")
        let bill = Bill(userID: "testID",
                        name: "Bob Ross",
                        date: Date().currentDateTimeAsString(),
                        location: "MacDonalds",
                        imageURL: "https://testurl.com",
                        items: nil)
        
        firebaseData.createBill(bill,
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
        removeTestBill(withID: bill.id)
    }
    
    func testCanRequestBillWithId() {
        var resultID = String()
        let userID = "jT9AZdggj0gYKJjGlYPsf4uSqko1"
        let id = addBillToFirebaseWith(userID: userID)
        let requestExpectation = expectation(description: "Request a bill")
        
        firebaseData.findBill(with: id, completion: { bill in
            if let bill = bill {
                resultID = bill.id
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 5) { _ in
            XCTAssertEqual(resultID, id)
        }
        removeTestBill(withID: id)
    }
    
    func testCanRequestAllUsersBills() {
        let requestExpectation = expectation(description: "Request a users bills")
        let userWithBillsID = "LookingForThis"
        let otherUserID = "NotLookingForThis"
        var resultID1 = String()
        var resultID2 = String()
        _ = addBillToFirebaseWith(userID: userWithBillsID)
        _ = addBillToFirebaseWith(userID: otherUserID)
        _ = addBillToFirebaseWith(userID: userWithBillsID)
        
        firebaseData.findBillsWith(userID: userWithBillsID,
                                   completion: { bills in
            if let bills = bills {
                resultID1 = bills[0].id
                resultID2 = bills[1].id
                bills.forEach { bill in
                    self.removeTestBill(withID: bill.id)
                }
                XCTAssertEqual(bills.count, 2)
            }
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { _ in
            XCTAssertEqual(resultID1, userWithBillsID)
            XCTAssertEqual(resultID2, userWithBillsID)
        }
    }
    
    func testCanRemoveBillFromFirebase() {
        var testSuccess = false
        let userID = "jT9AZdggj0gYKJjGlYPsf4uSqko1"
        let id = addBillToFirebaseWith(userID: userID)
        let requestExpectation = expectation(description: "Remove a bill")
        
        firebaseData.removeBill(with: id, completion: { (error) in
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
    }
    
    func addBillToFirebaseWith(userID: String) -> String {
        let bill = Bill(userID: userID,
                        name: "Bob Ross",
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
