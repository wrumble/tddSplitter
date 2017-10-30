//
//  OCRResultParsingTests.swift
//  BillTests
//
//  Created by Wayne Rumble on 25/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
@testable import Splitter

class OCRResultParsingTests: XCTestCase {
    
    let ocrResultConverter = OCRResultConverter()
    
    func testRecognizesTotalAtEndOfLine() {
        var ocrResult = "500ml 1664 êcole beer £8,000.000,0"
        let expectation = "8000000.0"
        let result = ocrResultConverter.convertToItems(&ocrResult,
                                                       billID: "billID")
        XCTAssertEqual(result.first?.price,
                       expectation)
    }
    
    func testReturnsZeroPriceIfNoPriceIsFound() {
        var ocrResult = "2 x 500ml 1664 êcole beer"
        let expectation = "0.0"
        let result = ocrResultConverter.convertToItems(&ocrResult,
                                                       billID: "billID")
        
        XCTAssertEqual(result.first?.price,
                       expectation)
    }
    
    func testReturnsItemNameOnly() {
        var ocrResult = "2 500ml êcole beer £8.0"
        let expectation = "500ml êcole beer"
        let result = ocrResultConverter.convertToItems(&ocrResult,
                                                       billID: "billID")
        
        XCTAssertEqual(result.first?.name,
                       expectation)
    }
    
    func testReturnsTwoItemsIfQuantityIsTwo() {
        var ocrResult = "2 500ml êcole beer £8.0"
        let expectation = 2
        let result = ocrResultConverter.convertToItems(&ocrResult,
                                                       billID: "billID")
        
        XCTAssertEqual(result.count,
                       expectation)
    }
    
    func testDividesItemPriceByQuantity() {
        var ocrResult = "2 x 500ml 1664 êcole beer £8,000.000,0 1"
        let expectation = "4000000.0"
        let result = ocrResultConverter.convertToItems(&ocrResult,
                                                       billID: "billID")
        
        XCTAssertEqual(result.first?.price,
                       expectation)
    }
}
