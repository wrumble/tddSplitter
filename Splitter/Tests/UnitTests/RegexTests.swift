//
//  RegexTests.swift
//  BillTests
//
//  Created by Wayne Rumble on 25/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
@testable import Splitter

class RegexTests: XCTestCase {
    
    let regex = Regex()
    
    func testReturnsTrueWhenContainsAMatch() {
        let ocrResult = "2 cheese burger £8.0"
        let pattern = "[0-9]+(\\.|,)[0-9]{1,2}"
        
        let result = regex.containsMatch(pattern,
                                         inString: ocrResult)
            
        XCTAssertTrue(result, "Does not contain a match")
    }
    
    func testReturnsCorrectMatch() {
        let ocrResult = "2 cheese burger £8.0"
        let pattern = "[0-9]+(\\.|,)[0-9]{1,2}"
        let expectation = ["8.0"]
        
        let result = regex.listMatches(pattern,
                                       inString: ocrResult)
            XCTAssertEqual(expectation, result)

    }
    
    func testReplacesOccurenceOfMatchWithString() {
        let ocrResult = "2 cheese burger £8.0"
        let pattern = "[0-9]+(\\.|,)[0-9]{1,2}"
        let expectation = "2 cheese burger £"
        
        let result = regex.replaceMatches(pattern,
                                          inString: ocrResult,
                                          withString: "")
        XCTAssertEqual(expectation, result)
    }
}
