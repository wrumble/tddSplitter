//
//  DateHelper.swift
//  Splitter
//
//  Created by Wayne Rumble on 24/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

extension Date {
    func currentDateTimeAsString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd/MM/yyyy"
        
        return formatter.string(from: date)
    }
}

extension UIViewController {
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(sender:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(sender:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = Layout.welcomeScreenKeyboardMovement
    }
    
    @objc private func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
}
