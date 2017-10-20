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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    private func setupHierarchy() {
        containerView.addSubview(quantityLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
        contentView.addSubview(containerView)
    }
    
    private func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        containerView.backgroundColor = .clear
        
        quantityLabel.textAlignment = .left
        quantityLabel.backgroundColor = .clear
        quantityLabel.backgroundColor = Color.carouselView
        quantityLabel.textColor = Color.carouselText
        quantityLabel.font = Font.carouselText

        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = Color.carouselText
        nameLabel.font = Font.carouselText

        priceLabel.textAlignment = .right
        priceLabel.backgroundColor = .clear
        priceLabel.textColor = Color.carouselText
        priceLabel.font = Font.carouselText
    }
    
    private func setupLayout() {
        containerView.pinToSuperview(edges: [.left, .right])
        containerView.pinToSuperviewTop(withConstant: -2, priority: .required, relatedBy: .equal)
        containerView.pinToSuperviewBottom(withConstant: -2, priority: .required, relatedBy: .equal)
        
        quantityLabel.pinToSuperview(edges: [.top, .left, .bottom])
        quantityLabel.contentCompressionResistancePriority(for: .horizontal)
        
        nameLabel.pinToSuperview(edges: [.top, .bottom])
        nameLabel.pinLeft(to: quantityLabel, anchor: .right)
        nameLabel.pinRight(to: priceLabel, anchor: .left)
        nameLabel.contentHuggingPriority(for: .horizontal)
        
        priceLabel.pinToSuperview(edges: [.top, .right, .bottom])
        priceLabel.contentCompressionResistancePriority(for: .horizontal)
    }
}
