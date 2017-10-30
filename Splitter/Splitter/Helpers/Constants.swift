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
    static let cameraButton = UIImage(named: "cameraIcon")
    static let homeButton = UIImage(named: "homeIcon")
    static let saveButton = UIImage(named: "saveIcon")
    static let deleteButton = UIImage(named: "deleteIcon")
    static let logoutButton = UIImage(named: "logoutIcon")
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
    static let imageInstructionText = "ImageInstructionText".localized
    
    //ActivityIndicator messages
    static let extractingTextMessage = "ExtractingTextMessage".localized
    static let loadingMessage = "LoadingMessage".localized
    static let loggingInMessage = "LoggingInMessage".localized
    static let registeringMessage = "RegisteringMessage".localized
    static let readingTextMessage = "ReadingTextMessage".localized
}

enum Layout {
    static let screenEdgeSpacer: CGFloat = 15
    static let cameraButtonHeightWidth: CGFloat = 45
    static let homeButtonHeightWidth: CGFloat = 45
    static let saveButtonHeightWidth: CGFloat = 45
    static let carouselViewCornerRadius: CGFloat = 10
    static let deleteButtonHeightWidth: CGFloat = 60
    static let logoutButtonHeightWidth: CGFloat = 60
    static let addButtonHeightWidth: CGFloat = 60
    static let titleLabelY: CGFloat = 22
    static let titleLabelHeight: CGFloat = 32
    static let titleLogoTextHeight: CGFloat = UIScreen.main.bounds.height/8
    static let textFieldHeight: CGFloat = 44
    static let buttonHeight: CGFloat = 44
    static let spacer: CGFloat = 5
    static let loginButtonYMovement = (Layout.buttonHeight + Layout.spacer) * 2
}

enum AccesID {
    static let carouselLocationLabel = "CarouselLocationLabel"
    static let carouselDateLabel = "CarouselDateLabel"
    static let imagePicker = "ImagePicker"
    static let instructionLabel = "InstructionLabel"
    static let cameraButton = "Camera"
    static let homeButton = "Home"
    static let saveButton = "Save"
    static let locationTextField = "Location"
    static let nameTextField = "Name"
    static let noBillsLabel = "NoBillsLabel"
    static let carouselNameLabel = "CarouselNameLabel"
    static let carouselView = "CarouselView"
    static let deleteButton = "Delete"
    static let logoutButton = "Logout"
    static let addButton = "Add"
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
    static let activityIndicatorDarkSpinner = UIColor(red: 33/255,
                                                      green: 33/255,
                                                      blue: 33/255,
                                                      alpha: 1.00)
    static let activityIndicatorLightSpinner = UIColor(red: 254/255,
                                                       green: 254/255,
                                                       blue: 254/255,
                                                       alpha: 0.60)
    static let activityIndicatorDarkBackground = UIColor(red: 33/255,
                                                         green: 33/255,
                                                         blue: 33/255,
                                                         alpha: 1.00)
    static let activityIndicatorLightBackground = UIColor(red: 254/255,
                                                          green: 254/255,
                                                          blue: 254/255,
                                                          alpha: 0.60)
    static let activityIndicatorDarkText = UIColor(red: 33/255,
                                           green: 33/255,
                                           blue: 33/255,
                                           alpha: 1.00)
    static let activityIndicatorLightText = UIColor(red: 254/255,
                                                    green: 254/255,
                                                    blue: 254/255,
                                                    alpha: 0.60)
    static let instructionLabelText = UIColor(red: 254/255,
                                           green: 254/255,
                                           blue: 254/255,
                                           alpha: 1.00)
    static let carouselText = UIColor(red: 33/255,
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
                                      alpha: 0.75)
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
    static let textFieldBackground = UIColor(red: 88/255,
                                             green: 130/255,
                                             blue: 145/255,
                                             alpha: 1.00)
    static let textFieldText = UIColor(red: 254/255,
                                       green: 254/255,
                                       blue: 254/255,
                                       alpha: 1.00)
    static let textFieldPlaceholder = UIColor(red: 17/255,
                                              green: 69/255,
                                              blue: 89/255,
                                              alpha: 1.00)
}

enum Font {
    static let tableViewText = UIFont.systemFont(ofSize: 20)
    static let carouselTitleText = UIFont.systemFont(ofSize: 24)
    static let carouselSubText = UIFont.systemFont(ofSize: 20)
    static let activityIndicator = UIFont.systemFont(ofSize: 18)
    static let instructionLabel = UIFont.systemFont(ofSize: 20)
    static let titleLabel = UIFont.systemFont(ofSize: 26)
    static let titleLogo = UIFont(name: "WalkwayBold", size: 200)
    static let toastFont = UIFont.systemFont(ofSize: 16)
}
