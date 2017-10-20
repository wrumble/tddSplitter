//
//  CarouselTableViewCell.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/10/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class CarouselTableViewCell: UITableViewCell {
    
    var containerView = UIView()
    var quantityLabel = UILabel()
    var nameLabel = UILabel()
    var priceLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "carouselTableViewCell")
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    private func setupHierarchy() {
        containerView.addSubview(quantityLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(containerView)
        contentView.addSubview(containerView)
    }
    
    private func setupViews() {
        quantityLabel.textAlignment = .left
        quantityLabel.backgroundColor = Color.carouselView
        quantityLabel.textColor = Color.carouselText
        
        nameLabel.textAlignment = .left
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = Color.carouselText

        priceLabel.textAlignment = .right
        priceLabel.backgroundColor = .clear
        priceLabel.textColor = Color.carouselText

    }
    
    private func setupLayout() {
        containerView.pinToSuperview(edges: [.left, .right])
        containerView.pinToSuperviewTop(withConstant: -2, priority: .required, relatedBy: .equal)
        containerView.pinToSuperviewBottom(withConstant: -2, priority: .required, relatedBy: .equal)
        
        quantityLabel.pinToSuperview(edges: [.top, .left, .bottom])
        
        nameLabel.pinToSuperview(edges: [.top, .bottom])
        nameLabel.pinLeft(to: quantityLabel, anchor: .right)
        nameLabel.pinRight(to: priceLabel, anchor: .left)

        priceLabel.pinToSuperview(edges: [.top, .right, .bottom])

    }
}
