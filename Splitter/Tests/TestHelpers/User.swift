//
//  User.swift
//  Splitter
//
//  Created by Wayne Rumble on 22/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation

class TestUser {
    var email: String!
    var password: String!
    var confirmationPassword: String?
    
    init(email: String, password: String, confirmationPassword: String?) {
        self.email = email
        self.password = password
        self.confirmationPassword = confirmationPassword
    }
}
