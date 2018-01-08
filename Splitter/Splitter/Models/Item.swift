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
    var price: String
    var creationID: String
    var billID: String
    
    init(name: String = "",
         price: String = "",
         creationID: String = "",
         billID: String) {
        self.id = UUID().uuidString
        self.name = name
        self.price = price
        self.creationID = creationID
        self.billID = billID
    }
    
    func toJSON() -> JSON {
        return [
            "id": id,
            "name": name,
            "price": price,
            "creationID": creationID,
            "billID": billID
        ]
    }
}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id &&
                lhs.name == rhs.name &&
                lhs.price == rhs.price &&
                lhs.billID == rhs.billID
    }
}
