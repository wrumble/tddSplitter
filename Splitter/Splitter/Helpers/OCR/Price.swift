//
//  Price.swift
//  Splitter
//
//  Created by Wayne Rumble on 10/01/2018.
//  Copyright © 2018 Wayne Rumble. All rights reserved.
//

class Price {
    
    private let regex = Regex()
    private var price = "0.0"
    
    func find(_ receiptLine: inout String, quantity: Int) -> String {
        if regex.contains(Pattern.price,
                          in: receiptLine) {
            price = regex.listMatches(of: Pattern.price,
                                      in: receiptLine).last!
            removePriceAndExtraCharactersAfter(&receiptLine)
            formatPrice()
        }
        
        return calculateIndividualPrice(quantity)
    }
    
    private func removePriceAndExtraCharactersAfter(_ receiptLine: inout String) {
        if let index = receiptLine.range(of: price)?.lowerBound {
            let substring = receiptLine[..<index]
            receiptLine = String(substring)
        }
    }
    
    private func formatPrice() {
        for decimalIndex in 2...3 {
            removeUnnecessaryPunctuation(decimalIndex: decimalIndex)
        }
    }
    
    private func removeUnnecessaryPunctuation(decimalIndex: Int) {
        var priceCharacters = Array(price)
        let index = priceCharacters.count - decimalIndex
        if priceCharacters[index] == "," || priceCharacters[index] == "." {
            price = String(Array(price).filter { Array("0123456789").contains($0) })
            let index = price.index(price.endIndex, offsetBy:  -decimalIndex + 1)
            price = price.replacingOccurrences(of: ".", with: "")
            price.insert(".", at: index)
        }
    }
    
    private func calculateIndividualPrice(_ quantity: Int) -> String {
        guard let totalPrice = Double(price) else { return "0.0" }
        let individualPrice = String(totalPrice/Double(quantity))
        
        return individualPrice
    }
}
