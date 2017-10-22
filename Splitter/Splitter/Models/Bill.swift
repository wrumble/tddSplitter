//
//  User.swift
//  UserTests
//
//  Created by Wayne Rumble on 21/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation

typealias JSON = [String: Any?]

protocol JSONable {
    var id: String { get }
    func toJSON() -> JSON
}

struct Bill: JSONable {
    
    var id: String
    var userID: String
    var name: String
    var creationDate: String
    var location: String?
    var imageURL: String
    var items: [Item]?
    
    init(id: String,
         userID: String,
         name: String,
         location: String?,
         imageURL: String,
         items: [Item]?) {
        
        self.id = id
        self.userID = userID
        self.name = name
        self.creationDate = Date().currentDateTimeAsString()
        self.location = location
        self.imageURL = imageURL
        self.items = items
    }
    
    func toJSON() -> JSON {
        return ["id": id,
                "userID": userID,
                "name": name,
                "location": location,
                "creationDate": creationDate,
                "imageURL": imageURL,
                "items": itemsAsJson()
        ]
    }
    
    func itemsAsJson() -> JSON {
        var itemsJson = JSON()
        items?.forEach { item in
            itemsJson[item.id] = item.toJSON()
        }
        return itemsJson
    }
    
    func totalPrice() -> String {
        var total = 0.0
        items?.forEach { item in
            total += Double(item.price)!
        }
        return String(total)
    }
}
