//
//  Quantity.swift
//  Splitter
//
//  Created by Wayne Rumble on 10/01/2018.
//  Copyright © 2018 Wayne Rumble. All rights reserved.
//

class Quantity {
    
    private let regex = Regex()
    
    func find(_ receiptLine: inout String) -> Int {
        var quantity = "1"
        
        if regex.contains(Pattern.numberOrXOrDash,
                          in: receiptLine) {
            quantity = regex.listMatches(of: Pattern.numberOrXOrDash,
                                         in: receiptLine).first!
            remove(Pattern.numberOrXOrDash,
                   from: &receiptLine)
            remove(Pattern.xOrDash,
                   from: &receiptLine)
        }
        quantity = quantity.trim()
        return Int(quantity)!
    }
    
    private func remove(_ pattern: String,
                        from string: inout String) {
        
        if regex.contains(pattern,
                          in: string) {
            string = regex.replaceMatch(of: pattern,
                                          in: string,
                                          with: "")!
        }
    }
}
