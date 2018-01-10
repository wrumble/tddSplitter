//
//  Name.swift
//  Splitter
//
//  Created by Wayne Rumble on 10/01/2018.
//  Copyright © 2018 Wayne Rumble. All rights reserved.
//

class Name {
    
    private let regex = Regex()
    
    func format(_ receiptLine: inout String) -> String {
        if regex.contains(Pattern.nameChars, in: receiptLine) {
            receiptLine = regex.listMatches(of: Pattern.nameChars, in: receiptLine).joined()
            removeIndividualItemPricings(&receiptLine)
            
            receiptLine = receiptLine.trim()
        }
        if receiptLine == "" {
            receiptLine = "Untitled"
        }
        return receiptLine
    }
    
    private func removeIndividualItemPricings(_ receiptLine: inout String) {
        receiptLine = regex.replaceMatch(of: Pattern.price,
                                           in: receiptLine,
                                           with: "")!
        receiptLine = receiptLine.trim()
        receiptLine  = regex.replaceMatch(of: Pattern.charsBeforeIndividualPrice,
                                            in: receiptLine,
                                            with: "")!
    }
}
