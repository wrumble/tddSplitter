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

    private var image = UIImage(named: "receipt1.jpg")!
    private var ocrRequest = OCRRequest()

    func testRequestReturnsExpectedJson() {
        var textResponse = String()
        let base64Image = image.base64EncodeImage()
        let requestExpectation = expectation(description: "Image text received")
        ocrRequest.uploadReceiptImage(image: base64Image,
                                      complete: { receiptText in
                if let receiptText = receiptText {
                    textResponse = receiptText
                }
                                        
                requestExpectation.fulfill()
            })
        waitForExpectations(timeout: 5) { _ in
            XCTAssertNotNil(textResponse)
        }
    }
    
    func testRequestReturnsNilWithInvalidBase64Image() {
        let gobbledigook = "aslkdghasldjgnlsdk"
        ocrRequest.uploadReceiptImage(image: gobbledigook,
                                      complete: { receiptText in
                                        XCTAssertNil(receiptText)
        })
        XCTFail()
    }
}
