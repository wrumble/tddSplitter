//
//  UserRepository.swift
//  Splitter
//
//  Created by Wayne Rumble on 22/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation

class UserRepository {
    let password = "password"
    let shortPassword = "passw"
    let differentPassword = "differentPassword"
    let incorrectPassword = "wrongpassword"
    let registeredEmail = "alreadyregistereduser@email.com"
    let unregisteredEmail = "unregistered@email.com"
    let invalidEmail = "invalid@email"
    
    func getValidUser() -> TestUser {
        return TestUser(email: registeredEmail,
                        password: password,
                        confirmationPassword: password)
    }
    
    func getInvalidEmailUser() -> TestUser {
        return TestUser(email: invalidEmail,
                        password: password,
                        confirmationPassword: password)
    }
    
    func getUsedEmailUser() -> TestUser {
        return TestUser(email: registeredEmail,
                        password: password,
                        confirmationPassword: password)
    }
    
    func getUnregisteredEmailUser() -> TestUser {
        return TestUser(email: unregisteredEmail,
                        password: password,
                        confirmationPassword: password)
    }
    
    func getTooShortPasswordUser() -> TestUser {
        return TestUser(email: registeredEmail,
                        password: shortPassword,
                        confirmationPassword: shortPassword)
    }
    
    func getTooShortConfirmationPasswordUser() -> TestUser {
        return TestUser(email: registeredEmail,
                        password: password,
                        confirmationPassword: shortPassword)
    }
 
    func getDifferentConfirmationPasswordUser() -> TestUser {
        return TestUser(email: registeredEmail,
                        password: password,
                        confirmationPassword: differentPassword)
    }
    
    func getIncorrectPasswordUser() -> TestUser {
        return TestUser(email: registeredEmail,
                        password: incorrectPassword,
                        confirmationPassword: shortPassword)
    }
    
}
