//
//  User.swift
//  UserTests
//
//  Created by Wayne Rumble on 21/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Firebase

struct Bill {
    let key: String
    let reference: DatabaseReference?
    
    var id: String
    var name: String
    var date: String
    var location: String
    var imageURL: String
    
    init(name: String, date: String, location: String, imageURL: String) {
        self.key = "Bill"
        self.reference = nil
        
        self.id = UUID().uuidString
        self.name = name
        self.date = date
        self.location = location
        self.imageURL = imageURL
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        location = snapshotValue["location"] as! String
        date = snapshotValue["date"] as! String
        imageURL = snapshotValue["imageURL"] as! String
        id = snapshotValue["id"] as! String
        
        reference = snapshot.ref
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
