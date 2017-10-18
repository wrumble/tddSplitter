//
//  CarouselLabel.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class CarouselLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        textColor = Color.carouselText
        font = Font.carouselText
        numberOfLines = 0
        minimumScaleFactor = 0.1
        adjustsFontSizeToFitWidth = true
    }
}
