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
        if receiptLine == "" || receiptLine == " " { return [] }
        var itemArray = [Item]()
        let itemQuantity = returnItemQuantity(&receiptLine)
        var itemPrice: String {
            if String(returnItemPrice(&receiptLine)) == "0.0" {
                return "0.0"
            }
            return String(returnItemPrice(&receiptLine) / Double(itemQuantity) )
        }
        
        formatItemName(&receiptLine)
        
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
        let numberAndXPattern = "\\d{1,2}(\\s[xX]|[xX])"
        let justNumberPattern = "^\\d{1,2}\\s"
        var quantity = "1"
        
        if regex.containsMatch(numberAndXPattern,
                               inString: receiptLine) {
            extractAndRemove(&quantity,
                             from: &receiptLine,
                             with: numberAndXPattern)
        } else if regex.containsMatch(justNumberPattern,
                                      inString: receiptLine) {
            extractAndRemove(&quantity,
                             from: &receiptLine,
                             with: justNumberPattern)
        }
        
        return Int(quantity.trimmingCharacters(in: .whitespacesAndNewlines))!
    }
    
    private func extractAndRemove(_ quantity: inout String,
                                  from string: inout String,
                                  with pattern: String) {
        quantity = regex.listMatches(pattern,
                                     inString: string).first!
        quantity = regex.replaceMatches("[xX\\s]",
                                        inString: quantity,
                                        withString: "")!
        string = regex.replaceMatches(pattern,
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
        var priceCharacters = Array(price.characters)
        let index = priceCharacters.count - decimalIndex
        if priceCharacters[index] == "," {
            price = String(price.characters.filter { "0123456789".characters.contains($0) })
            let index = price.index(price.endIndex, offsetBy:  -decimalIndex + 1)
            price.insert(".", at: index)
        }
    }

    private func formatItemName(_ receiptLine: inout String) {
        let wantedCharacters = "\\d+|\\d+[A-z]+|[\\u00C0-\\u017E A-z@.,]+"
        if regex.containsMatch(wantedCharacters,
                               inString: receiptLine) {
             receiptLine = regex.listMatches(wantedCharacters, inString: receiptLine)
                                .joined()
                                .trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            receiptLine = "Untitled"
        }
    }
}
