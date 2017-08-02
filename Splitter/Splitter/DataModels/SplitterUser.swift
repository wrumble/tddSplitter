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
    var stripeID: String
    var name: String
    var email: String
    var hasPaid: [String: Bool]
    var isPayingBill: [String: Bool]
    var bills: [Bill]
    
    init(id: String, email: String) {
        self.id = ""
        self.stripeID = ""
        self.name = ""
        self.email = email
        self.hasPaid = [:]
        self.isPayingBill = [:]
        self.bills = []
    }
}
