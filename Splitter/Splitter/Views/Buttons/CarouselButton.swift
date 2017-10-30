//
//  CarouselButton.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/10/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class CarouselButton: UIButton {
    
    required init() {
        super.init(frame: .zero)
        setupView()
        //applyMaskLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        backgroundColor = Color.buttonBackground
        setTitleColor(Color.buttonText, for: .normal)
        titleLabel?.font = Font.carouselSubText
    }
    
    private func applyMaskLayer() {
        let maskBounds = bounds
        let maskPath = UIBezierPath(roundedRect: maskBounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: Layout.carouselViewCornerRadius,
                                                    height: Layout.carouselViewCornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
