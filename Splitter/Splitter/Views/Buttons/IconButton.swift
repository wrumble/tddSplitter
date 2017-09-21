//
//  AddButton.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class IconButton: UIButton {
    
    private var accessID: String!
    private var iconImage: UIImage!
    
    required init(accessID: String, iconImage: UIImage) {
        super.init(frame: .zero)
        
        self.accessID = accessID
        self.iconImage = iconImage
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        accessibilityIdentifier = accessID
        backgroundColor = .clear
        setBackgroundImage(iconImage, for: .normal)
    }
}
