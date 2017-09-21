//
//  TitleLogoLabel.swift
//  Splitter
//
//  Created by Wayne Rumble on 01/08/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class TitleLabelLogo: UILabel {
    
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
        text = Localized.splitterTitleLogoText
        textColor = Color.titleLogoText
        textAlignment = .center
        font = Font.titleLogo
        numberOfLines = 0
        minimumScaleFactor = 0.1
        adjustsFontSizeToFitWidth = true
    }
}
