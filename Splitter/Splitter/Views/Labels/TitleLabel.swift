//
//  TitleLabel.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
        
    required init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        accessibilityIdentifier = AccesID.titleLabel
        backgroundColor = Color.titleLabelBackground
        textColor = Color.titleLabelText
        textAlignment = .center
        font = Font.titleLabel
        numberOfLines = 0
        minimumScaleFactor = 0.1
        adjustsFontSizeToFitWidth = true
    }
}
