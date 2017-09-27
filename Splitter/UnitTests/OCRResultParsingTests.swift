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
        let ocrResult = "500ml 1664 êcole beer £8,000.000,0"
        let expectation = "8000000.0"
        let result = ocrResultConverter.convertToItems(ocrResult,
                                                      with: "billID")
        XCTAssertEqual(result.first?.price,
                       expectation)
    }
    
    func testReturnsZeroPriceIfNoPriceIsFound() {
        let ocrResult = "2 x 500ml 1664 êcole beer"
        let expectation = "0.0"
        let result = ocrResultConverter.convertToItems(ocrResult,
                                                      with: "billID")
        
        XCTAssertEqual(result.first?.price,
                       expectation)
    }
    
    func testReturnsItemNameOnly() {
        let ocrResult = "2 500ml êcole beer £8.0"
        let expectation = "500ml êcole beer"
        let result = ocrResultConverter.convertToItems(ocrResult,
                                                      with: "billID")
        
        XCTAssertEqual(result.first?.name,
                       expectation)
    }
    
    func testReturnsQuantity() {
        let ocrResult = "2 x 500ml 1664 êcole beer £8.0"
        let expectation = 2
        let result = ocrResultConverter.returnItemQuantity(ocrResult)
        
        XCTAssertEqual(result,
                       expectation)
    }
    
    func testReturnsTwoItemsIfQuantityIsTwo() {
        let ocrResult = "2 500ml êcole beer £8.0"
        let expectation = 2
        let result = ocrResultConverter.convertToItems(ocrResult,
                                                      with: "billID")
        
        XCTAssertEqual(result.count,
                       expectation)
    }
    
    func testDividesItemPriceByQuantity() {
        let ocrResult = "2 x 500ml 1664 êcole beer £8,000.000,0"
        let expectation = "4000000.0"
        let result = ocrResultConverter.convertToItems(ocrResult,
                                                       with: "billID")
        
        XCTAssertEqual(result.first?.price,
                       expectation)
    }
}
