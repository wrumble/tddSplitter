//
//  OCRResultConverter.swift
//  Splitter
//
//  Created by Wayne Rumble on 25/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class OCRResultConverter {
    
    let regex = Regex()
    var creationCount = 0
    
    func convertToItems(_ receiptLine: inout String,
                        billID: String) -> [Item] {
        if receiptLine.trimmingCharacters(in: .whitespacesAndNewlines) == "" { return [] }
        var itemArray = [Item]()
        let itemQuantity = returnItemQuantity(&receiptLine)
        let totalPrice = returnItemPrice(&receiptLine)
        let itemPrice = String(totalPrice/Double(itemQuantity))
        formatItemName(&receiptLine, itemPrice: itemPrice)
        
        if itemQuantity == 0 {
            let item = Item(name: receiptLine,
                            price: itemPrice,
                            creationID: String(creationCount),
                            billID: billID)
            
            itemArray.append(item)
        } else {
            for _ in 0..<itemQuantity {
                let item = Item(name: receiptLine,
                                price: itemPrice,
                                creationID: String(creationCount),
                                billID: billID)
                itemArray.append(item)
            }
        }
        
        creationCount += 1
        return itemArray
    }
    
    private func returnItemQuantity(_ receiptLine: inout String) -> Int {
        let numberXDashPattern = "^\\d+(?=\\s*[xX-]|\\s)"
        var quantity = "1"
        
        if regex.containsMatch(numberXDashPattern,
                               inString: receiptLine) {
            extractAndRemove(&quantity,
                             from: &receiptLine,
                             with: numberXDashPattern)
        }
        
        return Int(quantity.trimmingCharacters(in: .whitespacesAndNewlines))!
    }
    
    private func extractAndRemove(_ quantity: inout String,
                                  from string: inout String,
                                  with pattern: String) {
        quantity = regex.listMatches(pattern,
                                     inString: string).first!
        string = regex.replaceMatches(pattern,
                                       inString: string,
                                       withString: "")!
        string = regex.replaceMatches("\\s*[xX-]",
                                      inString: string,
                                      withString: "")!
    }
    
    private func returnItemPrice(_ receiptLine: inout String) -> Double {
        let pricePattern = "\\d{1,3}(?:[.,]\\d{3})*(?:[.,]\\d{1,2})"
        var price = "0.0"
        if regex.containsMatch(pricePattern,
                               inString: receiptLine) {
            price = regex.listMatches(pricePattern,
                                      inString: receiptLine).last!
            if let index = receiptLine.range(of: price)?.lowerBound {
                let substring = receiptLine[..<index]
                receiptLine = String(substring)
            }
            normalizePrice(&price)
        }
        return Double(price)!
    }
    
    private func normalizePrice(_ price: inout String) {
        removeExtraCharactersFrom(&price, decimalIndex: 3)
        removeExtraCharactersFrom(&price, decimalIndex: 2)
    }
    
    private func removeExtraCharactersFrom(_ price: inout String,
                                           decimalIndex: Int) {
        var priceCharacters = Array(price)
        let index = priceCharacters.count - decimalIndex
        if priceCharacters[index] == "," || priceCharacters[index] == "." {
            price = String(Array(price).filter { Array("0123456789").contains($0) })
            let index = price.index(price.endIndex, offsetBy:  -decimalIndex + 1)
            price = price.replacingOccurrences(of: ".", with: "")
            price.insert(".", at: index)
        }
    }

    private func formatItemName(_ receiptLine: inout String,
                                itemPrice: String) {
        let wantedCharacters = "\\d+|\\d+[A-z]+|[\\u00C0-\\u017E A-z@.,]+"
        receiptLine = receiptLine.replacingOccurrences(of: "_", with: "")
        if regex.containsMatch(wantedCharacters,
                               inString: receiptLine) {
             receiptLine = regex.listMatches(wantedCharacters, inString: receiptLine)
                                .joined()
            removeIndividualItemPricings(&receiptLine, itemPrice: itemPrice)
            receiptLine = receiptLine.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if receiptLine == "" {
            receiptLine = "Untitled"
        }
    }
    
    private func removeIndividualItemPricings(_ receiptLine: inout String,
                                              itemPrice: String) {
        let pricePattern = "\\d{1,3}(?:[.,]\\d{3})*(?:[.,]\\d{1,2})"
        receiptLine = regex.replaceMatches(pricePattern,
                             inString: receiptLine,
                             withString: "")!
        receiptLine = receiptLine.trimmingCharacters(in: .whitespacesAndNewlines)
        receiptLine  = regex.replaceMatches("\\s*[@a80]$",
                                   inString: receiptLine,
                                   withString: "")!
    }
}
