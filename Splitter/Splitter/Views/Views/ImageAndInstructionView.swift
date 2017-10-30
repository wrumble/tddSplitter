//
//  ImageAndInstructionView.swift
//  Splitter
//
//  Created by Wayne Rumble on 21/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class ImageAndInstructionView: UIImageView {

    var instructionLabel = InstructionLabel()
    var base64Image: String!
    
    override var image: UIImage? {
        didSet {
            base64Image = image?.base64EncodeImage()
        }
    }
    
    required init() {
        super.init(frame: .zero)
        
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(instructionLabel)
    }
    
    private func setupViews() {
        backgroundColor = .clear
        contentMode = .scaleAspectFit
        
        instructionLabel.textAlignment = .center
        instructionLabel.text = Localized.imageInstructionText
        instructionLabel.font = Font.instructionLabel
    }
    
    private func setupLayout() {
        instructionLabel.pinToSuperviewEdges()
    }
}
