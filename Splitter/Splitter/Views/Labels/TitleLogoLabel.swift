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
    
    required init(frame: CGRect, accessID: String) {
        super.init(frame: frame)
        
        self.accessID = accessID
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        accessibilityIdentifier = accessID
        text = NSLocalizedString("SplitterTitleLogoText", comment: "")
        textColor = Color.titleLogoText
        textAlignment = .center
        font = UIFont(name: Font.titleLogoFontName, size: 200)
        numberOfLines = 0
        minimumScaleFactor = 0.1
        adjustsFontSizeToFitWidth = true
    }
}
