//
//  CarouselView.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class BillCarouselView: UIView {
    
    private var bill: Bill!
    
    private let titleLabel = CarouselTitleLabel()
    
    required init(bill: Bill) {
        super.init(frame: .zero)
        
        self.bill = bill
        
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupHierarchy() {
        addSubview(titleLabel)
    }
    
    private func setupViews() {
        accessibilityIdentifier = AccesID.carouselView
        isUserInteractionEnabled = true
        layer.cornerRadius = Layout.carouselViewCornerRadius
        backgroundColor = Color.carouselView
        
        titleLabel.text = bill.name
    }
    
    private func setupLayout() {
        titleLabel.pinToSuperview(edges: [.top, .left, .right])
    }
}
