//
//  OCRRequestTests.swift
//  UnitTests
//
//  Created by Wayne Rumble on 28/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
@testable import Splitter

class OCRRequestTests: XCTestCase {
    
    private var image: UIImage!
    private var imageData: String!
    private var ocrRequest: OCRRequest!
    
    override func setUp() {
        image = UIImage(named: "receipt1")!
        imageData = image.base64EncodeImage()
        ocrRequest = OCRRequest()
    }
    
    func testRequestReturnsExpectedJSON() {
        // swiftlint:disable:next line_length
        let expectedJSON = "4x Lowenbrau Original a 3,00 _ 12,00 1\n8x Weissbier dunkel _ a 3,30 _ 26,40 1\n3x Hefe-Weissbier a 3,30 - 9,90 1\n1x Saft 0,25 2,50 1\n1x Grosses Wasser 2,40 1\n1x Vegetarische Varia 9,90 1\n1x Gyros 8,90 1\n1x Baby Kalamari Gefu 12,90 1\n2x Gyros Folie a 9,90 19,80 i\n1x Schafskase Ofen 6,90 1\n1x Bifteki Metaxa 11,90 1\n1x Schweinefilet Meta 13,90 1\n1x Stifado 14,90 1\n1x Tee 2,10 1\n\n"
        let requestExpectation = expectation(description: "Receives JSON response")
        var returnedJSON = ""
        
        ocrRequest.uploadReceiptImage(image: imageData,
                                      complete: { (receiptText) in
            returnedJSON = receiptText!
            requestExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 10) { _ in
            XCTAssertEqual(expectedJSON, returnedJSON)
        }
    }
    
    func testRequestReturnsNilWithInvalidBase64Image() {
        let gobbledigook = "aslkdghasldjgnlsdk"
        var returnedJSON = "something"
        let requestExpectation = expectation(description: "Received nil")
        ocrRequest.uploadReceiptImage(image: gobbledigook,
                                      complete: { receiptText in
            returnedJSON = receiptText!
            requestExpectation.fulfill()
        })
        waitForExpectations(timeout: 10) { _ in
            XCTAssertEqual("", returnedJSON)
        }
    }
}
