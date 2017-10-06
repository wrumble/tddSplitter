//
//  Price.swift
//  Splitter
//
//  Created by Wayne Rumble on 05/10/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation

class Price {
    
//    private let pattern = "\\d{1,3}(?:[.,]\\d{3})*(?:[.,]\\d{1,2})?"
//    private let regex = Regex(pattern)
//    
//    func extract(from text: String) {
//        
//    }
//    
//    private func returnItemPrice(_ receiptLine: String) -> Double {
//        if let price = returnRegexResultsFrom(receiptLine,
//                                              pattern: pattern) {
//            let formattedPrice = formatPrice(price.last!)
//            return Double(formattedPrice)!
//        }
//        return 0.0
//    }
//    
//    private func formatPrice(_ price: String) -> String {
//        if price.characters.count > 3 {
//            var formattedPrice = removeExtraCharactersFrom(price, decimalIndex: 3)
//            formattedPrice = removeExtraCharactersFrom(price, decimalIndex: 2)
//            return formattedPrice
//        }
//        
//        return "0.0"
//    }
//    
//    private func removeExtraCharactersFrom(_ price: String,
//                                           decimalIndex: Int) -> String {
//        var newPrice = price
//        var priceCharacters = Array(price)
//        if priceCharacters[priceCharacters.count - decimalIndex] == "," {
//            newPrice = String(price.characters.filter { "01234567890".characters.contains($0) })
//            let index = newPrice.index(newPrice.endIndex, offsetBy:  -decimalIndex + 1)
//            newPrice.insert(".", at: index)
//        }
//        return newPrice.replacingOccurrences(of: ",", with: "")
//    }
}
