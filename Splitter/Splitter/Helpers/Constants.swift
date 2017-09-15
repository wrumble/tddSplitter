//
//  Constants.swift
//  Splitter
//
//  Created by Wayne Rumble on 31/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

enum Constant {
    static let minimumPasswordLength = 6
}

enum Localized {
    //Layout text
    static let myBillsViewControllerTitle = "MyBillsViewControllerTitle".localized
    static let splitterTitleLogoText = "SplitterTitleLogoText".localized

    //Toast messages
    static let invalidEmailError = "InvalidEmailError".localized
    static let invalidPasswordError = "InvalidPasswordError".localized
    static let passwordMismatchError = "PasswordMismatchError".localized
    static let successfulRegistraionText = "SuccessfulRegistraionText".localized
    static let successfulLoginText = "SuccessfulLoginText".localized
}

enum Layout {
    static let titleLogoTextHeight: CGFloat = UIScreen.main.bounds.height/8
    static let textFieldHeight: CGFloat = 44
    static let buttonHeight: CGFloat = 44
    static let spacer: CGFloat = 5
    static let loginButtonYMovement = (Layout.buttonHeight + Layout.spacer) * 2
}

enum AccesID {
    static let titleLogoLabel = "Title"
    static let emailTextField = "Email"
    static let passwordTextField = "Password"
    static let confirmPasswordTextField = "ConfirmPassword"
    static let loginButton = "Login"
    static let registerButton = "Register"
    static let toastLabel = "Toast"
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
    static let titleLogoFontName = UIFont(name: "WalkwayBold", size: 200)
    static let toastFont = UIFont(name: "Montserrat-Light", size: 14.0)
}
