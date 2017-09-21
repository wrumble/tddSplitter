//
//  CarouselTitleLabel.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class CarouselTitleLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        accessibilityIdentifier = AccesID.carouselTitleLabel
        backgroundColor = .clear
        textColor = Color.carouselTitleText
        textAlignment = .center
        font = Font.titleLabel
        numberOfLines = 0
        minimumScaleFactor = 0.1
        adjustsFontSizeToFitWidth = true
    }
}
