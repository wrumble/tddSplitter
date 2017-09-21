//
//  ImageAndInstructionView.swift
//  Splitter
//
//  Created by Wayne Rumble on 21/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class ImageAndInstructionView: UIImageView {

    var instructionLabel = UILabel()
    var receiptImageView = UIImage()
    
    required init() {
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(instructionLabel)
    }
    
    private func setupViews() {
        backgroundColor = .clear
        image = receiptImageView
        
        instructionLabel.textAlignment = .center
        instructionLabel.text = Localized.imageInstructionText
        instructionLabel.font = Font.instructionLabel
    }
}
