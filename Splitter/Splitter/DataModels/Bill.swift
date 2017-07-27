//
//  User.swift
//  UserTests
//
//  Created by Wayne Rumble on 21/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation

struct Bill {
    
    var id: String
    var name: String
    var date: String
    var location: String?
    var imageURL: String
    var items: [Item]?
    
    init(name: String, date: String, location: String?, imageURL: String, items: [Item]?) {
        self.id = UUID().uuidString
        self.name = name
        self.date = date
        self.location = location
        self.imageURL = imageURL
        self.items = items
    }
    
    func entitiesAsAny() -> Any {
        return [
            "name": name,
            "location": location,
            "date": date,
            "imageURL": imageURL,
            "id": id
        ]
    }
}
