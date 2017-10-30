//
//  ActivityIndicator.swift
//  Splitter
//
//  Created by Wayne Rumble on 04/10/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class ActivityIndicator: UIView {
    
    private var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    private var isDarkIndicator: Bool!
    private var width: CGFloat!
    private var height: CGFloat!
    private var size: CGFloat!
    private let activityIndictor = UIActivityIndicatorView(activityIndicatorStyle: .white)
    private let textLabel = UILabel()
    
    required init(text: String, isDarkIndicator: Bool = false) {
        super.init(frame: .zero)
        self.isDarkIndicator = isDarkIndicator
        self.width = UIScreen.main.bounds.width/2.0
        self.height = 50.0
        self.size = 40
        self.text = text
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isDarkIndicator = false
        self.text = ""
        self.setup()
    }
    
    private func setup() {
        addSubview(activityIndictor)
        addSubview(textLabel)
        
        activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = superview {
            setupView(superview)
            setupActivityIndicator()
            setupTextLabel()
            if isDarkIndicator { setDarkIndicator() }
        }
    }
    
    private func setupView(_ superview: UIView) {
        let x = superview.frame.width/2 - width/2
        let y = superview.frame.height/2 - height/2
        frame = CGRect(x: x,
                       y: y,
                       width: width,
                       height: height)
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        backgroundColor = Color.activityIndicatorLightBackground
    }
    
    private func setupActivityIndicator() {
        activityIndictor.frame = CGRect(x: 5,
                                        y: height/2 - size/2,
                                        width: size,
                                        height: size)
        activityIndictor.color = Color.activityIndicatorDarkSpinner
    }
    
    private func setupTextLabel() {
        textLabel.numberOfLines = 0
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.font = Font.activityIndicator
        textLabel.frame = CGRect(x: size + 5,
                                 y: 0,
                                 width: width - size - 15,
                                 height: height)
        textLabel.textColor = Color.activityIndicatorDarkText
    }
    
    private func setDarkIndicator() {
        backgroundColor = Color.activityIndicatorDarkBackground
        activityIndictor.color = Color.activityIndicatorLightSpinner
        textLabel.textColor = Color.activityIndicatorLightText
    }
}
