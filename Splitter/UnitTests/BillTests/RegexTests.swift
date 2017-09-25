//
//  RegexTests.swift
//  BillTests
//
//  Created by Wayne Rumble on 25/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest

class RegexTests: XCTestCase {
    
    func testReturnsTrueWhenContainsAMatch() {
        let ocrResult = "2 cheese burger £8.0"
        let pattern = "[0-9]+(\\.|,)[0-9]{1,2}"
        do {
            let regex = try Regex(pattern)
            let result = regex.containsMatch(input: ocrResult)
            
            XCTAssertTrue(result, "Does not contain a match")
        } catch {
            XCTFail()
        }
    }
    
    func testReturnsCorrectMatch() {
        let ocrResult = "2 cheese burger £8.0 dfgh"
        let pattern = "[0-9]+(\\.|,)[0-9]{1,2}"
        let expectation = "8.0"
        do {
            let regex = try Regex(pattern)
            let result = regex.returnsMatchesAsStrings(input: ocrResult).first
            
            XCTAssertEqual(expectation, result)
        } catch {
            XCTFail()
        }
    }
}
