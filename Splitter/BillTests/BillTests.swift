//
//  BillTests.swift
//  BillTests
//
//  Created by Wayne Rumble on 21/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
@testable import Splitter

class BillTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCanCreateNewBill() {
        let image = UIImage(named: "receipt1")
        var imageData = Data()
        imageData = UIImageJPEGRepresentation(image!, 0.8)!
        let bill = Bill(name: "Bob Ross", location: "MacDonalds", date: Date(), image: imageData)
        
    }
}
