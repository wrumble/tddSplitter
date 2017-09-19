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

enum Image {
    static let deleteButton = UIImage(named: "deleteIcon")
    static let addButton = UIImage(named: "addIcon")
}

enum Localized {
    //Layout text
    static let newBillViewControllerTitle = "NewBillViewControllerTitle".localized
    static let myBillsViewControllerTitle = "MyBillsViewControllerTitle".localized
    static let splitterTitleLogoText = "SplitterTitleLogoText".localized

    //Toast messages
    static let invalidEmailError = "InvalidEmailError".localized
    static let invalidPasswordError = "InvalidPasswordError".localized
    static let passwordMismatchError = "PasswordMismatchError".localized
    static let successfulRegistraionText = "SuccessfulRegistraionText".localized
    static let successfulLoginText = "SuccessfulLoginText".localized
    
    //Bills Messages
    static let noBillsMessage = "NoBillsMessage".localized

}

enum Layout {
    static let carouselViewX: CGFloat = UIScreen.main.bounds.width * 0.07
    static let carouselViewY: CGFloat = titleLabelY * 2 + spacer
    static let carouselViewWidth: CGFloat = UIScreen.main.bounds.width - (carouselViewX * 2)
    static let carouselViewHeight: CGFloat = UIScreen.main.bounds.height -
                                             addButtonHeightWidth - spacer -
                                             carouselViewY
    static let carouselViewCornerRadius: CGFloat = 10
    static let deleteButtonHeightWidth: CGFloat = 60
    static let addButtonHeightWidth: CGFloat = 60
    static let titleLabelY: CGFloat = 22
    static let titleLogoTextHeight: CGFloat = UIScreen.main.bounds.height/8
    static let textFieldHeight: CGFloat = 44
    static let buttonHeight: CGFloat = 44
    static let spacer: CGFloat = 5
    static let loginButtonYMovement = (Layout.buttonHeight + Layout.spacer) * 2
}

enum AccesID {
    static let noBillsLabel = "NoBillsLabel"
    static let carouselTitleLabel = "CarouselTitleLabel"
    static let carouselView = "CarouselView"
    static let deleteButton = "DeleteButton"
    static let addButton = "AddButton"
    static let titleLabel = "TitleLabel"
    static let titleLogoLabel = "TitleLogo"
    static let emailTextField = "Email"
    static let passwordTextField = "Password"
    static let confirmPasswordTextField = "ConfirmPassword"
    static let loginButton = "Login"
    static let registerButton = "Register"
    static let toastLabel = "Toast"
}

enum Color {
    static let noBillsText = UIColor(red: 254/255,
                                           green: 254/255,
                                           blue: 254/255,
                                           alpha: 1.00)
    static let carouselTitleText = UIColor(red: 33/255,
                                           green: 33/255,
                                           blue: 33/255,
                                           alpha: 1.00)
    static let carouselTitleLabel = UIColor(red: 33/255,
                                       green: 33/255,
                                       blue: 33/255,
                                       alpha: 1.00)
    static let carouselView = UIColor(red: 254/255,
                                      green: 254/255,
                                      blue: 254/255,
                                      alpha: 0.85)
    static let titleLabelBackground = UIColor(red: 254/255,
                                              green: 254/255,
                                              blue: 254/255,
                                              alpha: 0.60)
    static let titleLabelText = UIColor(red: 33/255,
                                        green: 33/255,
                                        blue: 33/255,
                                        alpha: 1.00)
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
    static let titleLabelFont = UIFont.systemFont(ofSize: 26)
    static let titleLogoFont = UIFont(name: "WalkwayBold", size: 200)
    static let toastFont = UIFont.systemFont(ofSize: 16)
}
