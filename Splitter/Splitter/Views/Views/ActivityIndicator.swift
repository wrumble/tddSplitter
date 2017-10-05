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
    
    private var width: CGFloat!
    private var height: CGFloat!
    private var size: CGFloat!
    private let activityIndictor = UIActivityIndicatorView(activityIndicatorStyle: .white)
    private let textLabel = UILabel()
    
    required init(text: String) {
        super.init(frame: .zero)
        self.width = UIScreen.main.bounds.width/2.0
        self.height = 50.0
        self.size = 40
        self.text = text
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        backgroundColor = Color.activityIndicatorBackground
    }
    
    private func setupActivityIndicator() {
        activityIndictor.frame = CGRect(x: 5,
                                        y: height/2 - size/2,
                                        width: size,
                                        height: size)
        activityIndictor.color = Color.activityIndicatorSpinner
    }
    
    private func setupTextLabel() {
        textLabel.numberOfLines = 0
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.textColor = Color.activityIndicatorText
        textLabel.font = Font.activityIndicator
        textLabel.frame = CGRect(x: size + 5,
                                 y: 0,
                                 width: width - size - 15,
                                 height: height)
    }
}
