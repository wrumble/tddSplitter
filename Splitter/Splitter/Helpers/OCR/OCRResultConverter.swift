//
//  OCRResultConverter.swift
//  Splitter
//
//  Created by Wayne Rumble on 25/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class ItemFactory {
    
    private let regex = Regex()
    private let quantity = Quantity()
    private let price = Price()
    private let name = Name()
    
    private var creationCount = 0
    
    func convertToItems(_ receiptLine: inout String,
                        billID: String) -> [Item] {
        if receiptLine.trim() == "" { return [] }
        var itemArray = [Item]()
        let itemQuantity = quantity.find(&receiptLine)
        let itemPrice = price.find(&receiptLine, quantity: itemQuantity)
        let itemName = name.format(&receiptLine)
        
        func createItem() {
            let item = Item(name: itemName,
                            price: itemPrice,
                            creationID: String(creationCount),
                            billID: billID)
            
            itemArray.append(item)
        }
        
        if itemQuantity == 0 {
            createItem()
        } else {
            for _ in 0..<itemQuantity {
                createItem()
            }
        }
        
        creationCount += 1
        return itemArray
    }
}
