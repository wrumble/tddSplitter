//
//  EmailTextField.swift
//  Splitter
//
//  Created by Wayne Rumble on 31/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class SplitterTextField: UITextField, UITextFieldDelegate {
    
    var accessID: String!
    
    required init(frame: CGRect, accessID: String) {
        super.init(frame: frame)
        self.accessID = accessID
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        delegate = self
        backgroundColor = Color.textFieldBackground
        accessibilityIdentifier = accessID
        textAlignment = .center
        returnKeyType = .done
        autocapitalizationType = .none
        autocorrectionType = .no
        placeholder = NSLocalizedString("\(accessID!)PlaceHolder", comment: "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
}
