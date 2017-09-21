//
//  NoBillsLabel.swift
//  Splitter
//
//  Created by Wayne Rumble on 19/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class InstructionLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        accessibilityIdentifier = AccesID.instructionLabel
        backgroundColor = .clear
        textColor = Color.instructionLabelText
        numberOfLines = 0
        textAlignment = .center
        font = Font.instructionLabel
        clipsToBounds = true
        sizeToFit()
    }
}
