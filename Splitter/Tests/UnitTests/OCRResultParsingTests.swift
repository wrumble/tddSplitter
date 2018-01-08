//
//  OCRResultParsingTests.swift
//  BillTests
//
//  Created by Wayne Rumble on 25/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
@testable import Splitter

enum ItemEnum {
    case price
    case name
    case quantity
}

class OCRResultParsingTests: XCTestCase {
    
    private let ocrResultConverter = OCRResultConverter()
    private var nameResultsArray: [String] {
        return createResultsArray(for: .name)
    }
    private var priceResultsArray: [String] {
        return createResultsArray(for: .price)
    }
    private var quantityResultsArray: [String] {
        return createResultsArray(for: .quantity)
    }
    
    fileprivate let possibleReceiptValues = ["2 500ml 1664 êcole beer £8,000,000.0",
                                             //"2x 500ml 1664 êcole beer", this doesn't work yet
                                             "2 500ml 1664 êcole beer £8.000.000,0",
                                             "2 x 500ml 1664 êcole beer £8,000.000,0 1",
                                             "2 x 500ml 1664 êcole beer @ £4,000,000.00 £8,000.000,0 1"]
    
    func testReturnsUntitledIfNoNameIsFound() {
        var ocrResult = "2 x £8,000,000.0"
        let expectation = "Untitled"
        let result = ocrResultConverter.convertToItems(&ocrResult,
                                                       billID: "billID")
        
        XCTAssertEqual(result.first?.name,
                       expectation)
    }
    
    func testEmptyStringReturnsEmptyArray() {
        var ocrResult = "                   "//Contains spaces and tabs
        let expectation = [Item]()
        let result = ocrResultConverter.convertToItems(&ocrResult,
                                                       billID: "billID")
        
        XCTAssertEqual(result, expectation)
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
        let expectationArray = createExpectationArray(for: "500ml 1664 êcole beer")
        
        XCTAssertEqual(nameResultsArray,
                       expectationArray)
    }
    
    func testReturnsItemPrice() {
        let expectationArray = createExpectationArray(for: "4000000.0")
        
        XCTAssertEqual(priceResultsArray,
                       expectationArray)
    }
    func testReturnsItemQuantity() {
        let expectationArray = createExpectationArray(for: "2")
        
        XCTAssertEqual(quantityResultsArray,
                       expectationArray)
    }
}

extension OCRResultParsingTests {
    fileprivate func createExpectationArray(for value: String) -> [String] {
        var expectationArray = [String]()
        for _ in 0...possibleReceiptValues.count - 1 {
            expectationArray.append(value)
        }
        return expectationArray
    }
    
    fileprivate func createResultsArray(for itemValue: ItemEnum) -> [String] {
        var resultArray = [String]()
        possibleReceiptValues.forEach { reciptLine in
            var line = reciptLine
            let result = ocrResultConverter.convertToItems(&line,
                                                           billID: "billID")
            switch itemValue {
            case .price:
                resultArray.append(result.first!.price)
            case .name:
                resultArray.append(result.first!.name)
            case .quantity:
                resultArray.append(String(result.count))
            }
        }
        return resultArray
    }
}
