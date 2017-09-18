//
//  AddButton.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class AddButton: UIButton {
    
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
        backgroundColor = .clear
        setBackgroundImage(Image.addButton, for: .normal)
        
        addHeightConstraint(with: Layout.addButtonHeightWidth)
        addWidthConstraint(with: Layout.addButtonHeightWidth)
    }
}
