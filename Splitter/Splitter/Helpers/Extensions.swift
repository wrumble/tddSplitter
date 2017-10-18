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
        formatter.dateFormat = "dd/MM/yyyy"
        
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
    
    func passwordReachesMinimumLength() -> Bool {
        let passwordReg = "^.{\(Constant.minimumPasswordLength),}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordReg)
        
        if passwordTest.evaluate(with: self.text) == false {
            self.becomeFirstResponder()
            return false
        }
        return true
    }
}

extension UIImage {
    func base64EncodeImage() -> String {
        var base64String = ""
        if CIImage(image: self) != nil {
            let imagedata = UIImageJPEGRepresentation(self, 1.0)!
            base64String = imagedata.base64EncodedString(options: .lineLength64Characters)
        }
        return base64String
    }
}

extension UIViewController {
    func showToast(in toastSuperView: UIView, with text: String) {
        let toastLabel = ToastLabel()
        toastLabel.text = text
        toastSuperView.addSubview(toastLabel)
        layoutToastLabel(toastLabel)
        animateToastLabel(toastLabel)
    }
    
    private func layoutToastLabel(_ toastLabel: ToastLabel) {
        toastLabel.centerYToSuperview()
        toastLabel.pinToSuperview(edges: [.left, .right])
    }
    
    private func animateToastLabel(_ toastLabel: ToastLabel) {
        UIView.animate(withDuration: 2.5, delay: 0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.hide()
        })
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment:"")
    }
}

extension UIView {
    func show() {
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = false
        }
    }
    
    func hide() {
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = true
        }
    }
}
