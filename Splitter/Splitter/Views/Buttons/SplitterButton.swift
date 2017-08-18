//
//  SplitterButton.swift
//  Splitter
//
//  Created by Wayne Rumble on 31/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class SplitterButton: UIButton {
    
    var accessID: String!
    
    required init(frame: CGRect, accessID: String) {
        super.init(frame: frame)
        
        self.accessID = accessID
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        let titleText = NSLocalizedString("\(accessID!)ButtonTitle", comment: "")
        
        accessibilityIdentifier = accessID
        backgroundColor = Color.buttonBackground
        setTitle(titleText, for: .normal)
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = Color.buttonText
    }
}
