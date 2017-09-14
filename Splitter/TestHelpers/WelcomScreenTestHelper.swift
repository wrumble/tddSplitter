//
//  WelcomScreenTestHelper.swift
//  WelcomeScreenTests
//
//  Created by Wayne Rumble on 23/08/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
import Foundation

enum TestAccesID {
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
