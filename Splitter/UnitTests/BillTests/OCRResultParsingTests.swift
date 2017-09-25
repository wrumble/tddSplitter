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
        let ocrResult = "2 cheese burger £8.0"
        let result = ocrResultConverter.convertToDictionary(ocrResult)
        
        XCTAssertEqual(result.price, "8.0")
    }
}
