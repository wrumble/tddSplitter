//
//  ToastLabel.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/08/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class ToastLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        accessibilityIdentifier = AccesID.toastLabel
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        textColor = .white
        numberOfLines = 0
        textAlignment = .center
        font = Font.toastFont
        alpha = 1.0
        clipsToBounds = true
        sizeToFit()
    }
}
