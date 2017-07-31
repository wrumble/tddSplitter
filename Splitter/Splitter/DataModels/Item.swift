//
//  Item.swift
//  Splitter
//
//  Created by Wayne Rumble on 27/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation

struct Item: JSONable {
    
    var id: String
    var name: String
    var price: Double
    var creationDate: String
    var billID: String
    
    init(name: String, price: Double, billID: String) {
        self.id = UUID().uuidString
        self.name = name
        self.price = price
        self.creationDate = Date().currentDateTimeAsString()
        self.billID = billID
    }
    
    func toJSON() -> JSON {
        return [
            "id": id,
            "name": name,
            "price": price,
            "creationDate": creationDate,
            "billID": billID
        ]
    }
}
