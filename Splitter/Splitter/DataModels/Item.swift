//
//  Item.swift
//  Splitter
//
//  Created by Wayne Rumble on 27/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation

struct Item {
    
    var id: String
    var name: String
    var price: Double
    var createionDate: String
    var billID: String
    
    init(name: String, price: Double, billID: String) {
        self.id = UUID().uuidString
        self.name = name
        self.price = price
        self.createionDate = Date().currentDateTimeAsString()
        self.billID = billID
    }
    
    func entitiesAsAny() -> Any {
        return [
            "name": name,
            "price": price,
            "createionDate": createionDate,
            "billID": billID
        ]
    }
}
