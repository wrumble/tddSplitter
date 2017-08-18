//
//  DateHelper.swift
//  Splitter
//
//  Created by Wayne Rumble on 24/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit
import Foundation

extension Date {
    func currentDateTimeAsString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd/MM/yyyy"
        
        return formatter.string(from: date)
    }
}

extension UITextField {
    
    func containsValidEmail() -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
        
        if emailTest.evaluate(with: self.text) == false {
            self.becomeFirstResponder()
            return false
        }
        return true
    }
}

extension UIViewController {
    func showToast(with text: String) {
        let toastLabel = ToastLabel()
        toastLabel.text = text
        view.addSubview(toastLabel)
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}
