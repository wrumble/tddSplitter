//
//  Constants.swift
//  Splitter
//
//  Created by Wayne Rumble on 31/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

enum Layout {
    static let titleLogoTextHeight: CGFloat = UIScreen.main.bounds.height/8
    static let textFieldHeight: CGFloat = 44
    static let buttonHeight: CGFloat = 44
    static let spacer: CGFloat = 5
    static let loginButtonYMovement = (Layout.buttonHeight + Layout.spacer) * 2
    static let welcomeScreenKeyboardMovement = -((Layout.textFieldHeight + Layout.spacer) * 2 +
                                                 (Layout.buttonHeight + Layout.spacer) * 2)
}

enum AccesID {
    static let titleLogoLabel = "TitleLabel"
    static let emailTextField = "Email"
    static let passwordTextField = "Password"
    static let confirmPasswordTextField = "ConfirmPassword"
    static let loginButton = "Login"
    static let registerButton = "Register"
}

enum Color {
    static let titleLogoText = UIColor(red: 254/255,
                                       green: 254/255,
                                       blue: 254/255,
                                       alpha: 1.00)
    static let mainBackground = UIColor(red: 48/255,
                                        green: 63/255,
                                        blue: 158/255,
                                        alpha: 1.00)
    static let buttonBackground = UIColor(red: 33/255,
                                          green: 33/255,
                                          blue: 33/255,
                                          alpha: 1.00)
    static let buttonText = UIColor(red: 254/255,
                                    green: 254/255,
                                    blue: 254/255,
                                    alpha: 1.00)
    static let textFieldBackground = UIColor(red: 96/255,
                                             green: 125/255,
                                             blue: 138/255,
                                             alpha: 1.00)
    static let textFieldText = UIColor(red: 254/255,
                                       green: 254/255,
                                       blue: 254/255,
                                       alpha: 1.00)
    static let textFieldPlaceholder = UIColor(red: 117/255,
                                              green: 117/255,
                                              blue: 117/255,
                                              alpha: 1.00)
}

enum Font {
    static let titleLogo = "WalkwayBold"
}
