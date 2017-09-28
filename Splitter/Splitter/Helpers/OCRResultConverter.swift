//
//  OCRResultConverter.swift
//  Splitter
//
//  Created by Wayne Rumble on 25/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class OCRResultConverter {
        
    func convertToItems(_ receiptLine: String,
                        billID: String) -> [Item] {
        var itemArray = [Item]()
        let itemQuantity = returnItemQuantity(receiptLine)
        
        for _ in 0..<itemQuantity {
            var item = Item(billID: billID)
            
            item.price = String( returnItemPrice(receiptLine)/Double(itemQuantity) )
            item.name = returnItemName(receiptLine)
            itemArray.append(item)
        }
        
        return itemArray
    }
    
    func returnItemQuantity(_ receiptLine: String) -> Int {
        //This returns only integers less than 3 digits long
        let numberAndXPattern = "\\d+[xX]"
        let justNumberPattern = "^[0-9]{1,2}+$"
        let firstWord = String(describing: receiptLine.split(separator: " ")
                                                     .first!)
        if let quantity = returnRegexResultsFrom(firstWord,
                                                 pattern: numberAndXPattern) {
            var filteredQuantity = quantity.first?.replacingOccurrences(of: "x", with: "")
            filteredQuantity = filteredQuantity?.replacingOccurrences(of: "X", with: "")
            return Int(filteredQuantity!)!
        }
        if let quantity = returnRegexResultsFrom(firstWord,
                                                 pattern: justNumberPattern) {
            return Int(quantity.first!)!
        }
        return 1
    }
    
    private func returnItemPrice(_ receiptLine: String) -> Double {
        let pattern = "\\d{1,3}(?:[.,]\\d{3})*(?:[.,]\\d{1,2})?"
        if let price = returnRegexResultsFrom(receiptLine,
                                              pattern: pattern) {
            let formattedPrice = formatPrice(price.last!)
            return Double(formattedPrice)!
        }
        return 0.0
    }
    
    private func formatPrice(_ price: String) -> String {
        if price.characters.count > 3 {
            var formattedPrice = removeExtraCharactersFrom(price, decimalIndex: 3)
            formattedPrice = removeExtraCharactersFrom(price, decimalIndex: 2)
            return formattedPrice
        }

        return "0.0"
    }
    
    private func removeExtraCharactersFrom(_ price: String,
                                           decimalIndex: Int) -> String {
        var newPrice = price
        var priceCharacters = Array(price)
        if priceCharacters[priceCharacters.count - decimalIndex] == "," {
            newPrice = String(price.characters.filter { "01234567890".characters.contains($0) })
            let index = newPrice.index(newPrice.endIndex, offsetBy:  -decimalIndex + 1)
            newPrice.insert(".", at: index)
        }
        return newPrice.replacingOccurrences(of: ",", with: "")
    }
    
    private func returnItemName(_ receiptLine: String) -> String {
        let pattern = "\\d+[A-z]+|[\\u00C0-\\u017E A-z]+"
        if let price = returnRegexResultsFrom(receiptLine,
                                              pattern: pattern) {
            return price.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                        .joined(separator: " ")
                        .trimmingCharacters(in: .whitespacesAndNewlines)
            
        }
        return "Untitled Item"
    }
    
    private func returnRegexResultsFrom(_ text: String,
                                        pattern: String) -> [String]? {
        do {
            let regex = try Regex(pattern)
            if regex.containsMatch(input: text) {
                return regex.returnsMatchesAsStrings(input: text)
            } else {
                print("No match found with regex pattern")
                return nil
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
