//
//  NoBillsLabel.swift
//  Splitter
//
//  Created by Wayne Rumble on 19/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class NoBillsLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        accessibilityIdentifier = AccesID.noBillsLabel
        backgroundColor = .clear
        textColor = Color.noBillsText
        numberOfLines = 0
        textAlignment = .center
        font = Font.titleLabelFont
        clipsToBounds = true
        sizeToFit()
    }
}
