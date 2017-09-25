//
//  OCRResultConverter.swift
//  Splitter
//
//  Created by Wayne Rumble on 25/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class OCRResultConverter {
    
    func convertToDictionary(_ receiptLine: String) -> Item {
        var item = Item(name: "",
                        price: "",
                        billID: "")
        do {
            let regEx = "[0-9]+(\\.|,)[0-9]{1,2}"
            let range = NSRange(receiptLine.startIndex..., in: receiptLine)
            let priceRegularExpression = try NSRegularExpression(pattern: regEx)
            let results = priceRegularExpression.matches(in: receiptLine, range: range)
            if let match = results.last {
                let range = match.range(at: 0)
                if let reciptRange = Range(range, in: receiptLine) {
                    item.price = String(receiptLine[reciptRange])
                }
            }
        } catch let error {
            print(error)
        }
        return item
    }
//
//    private func returnPriceInText(_ text: String) -> String {
//        let priceRegEx = "[0-9]+(\\.|,)[0-9]{1,2}"
//        let range = NSRange(text.startIndex..., in: text)
//        let matches = matchesForRegexInText(regex: priceRegEx,
//                                            text: text,
//                                            range: )
//        if let match = matches.last {
//            let range = match.range(at: 0)
//            if let reciptRange = Range(range, in: text) {
//                return String(text[reciptRange])
//            }
//        }
//    }

    private func matchesForRegexInText(regex: String, text: String, range: NSRange) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matches(in: text,
                                        options: [],
                                        range: range)
            return results.map { nsString.substring(with: $0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
