//
//  TitleLabel.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
    var accessID: String!
    
    required init(accessID: String) {
        super.init(frame: .zero)
        
        self.accessID = accessID
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        accessibilityIdentifier = accessID
        textColor = Color.titleLabelText
        textAlignment = .center
        font = Font.titleLabelFont
        numberOfLines = 0
        minimumScaleFactor = 0.1
        adjustsFontSizeToFitWidth = true
    }
}
