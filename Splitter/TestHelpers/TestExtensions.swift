//
//  TestExtensions.swift
//  Splitter
//
//  Created by Wayne Rumble on 15/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest

enum AccessID {
    static let titleLogoLabel = "Title"
    static let emailTextField = "Email"
    static let passwordTextField = "Password"
    static let confirmPasswordTextField = "ConfirmPassword"
    static let loginButton = "Login"
    static let registerButton = "Register"
    static let toastLabel = "Toast"
}

extension XCTestCase {
    
    func createEmail(with functionName: String) -> String {
        let brackets = CharacterSet(charactersIn: "()")
        let cleanedFunctionName = functionName.components(separatedBy: brackets).joined()
        
        return "\(cleanedFunctionName)@email.com"
    }
}
