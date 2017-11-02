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
    
    func testRequestReturnsExpectedJson() {
        ocrRequest.uploadReceiptImage(image: imageData,
                                      complete: { (receiptText) in
            print(receiptText)
            })
    }
}
