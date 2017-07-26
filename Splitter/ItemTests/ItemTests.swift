//
//  ItemTests.swift
//  ItemTests
//
//  Created by Wayne Rumble on 26/07/2017.
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
        let requestExpectation = expectation(description: "Creates an Item")
        let item = Item(name: "Baked Beans",
                        price: 3.50,
                        creationDate: Date().currentDateTimeAsString(),
                        quantity: 1,
                        billID: "testBillID")
        
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
}
