//
//  User.swift
//  Splitter
//
//  Created by Wayne Rumble on 27/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation
import Firebase

struct SplitterUser {
    
    var id: String
    var email: String
    
    init(id: String,
         email: String) {
        self.id = id
        self.email = email
    }
}
