//
//  ToastLabel.swift
//  Splitter
//
//  Created by Wayne Rumble on 18/08/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class ToastLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        animateToastLabel()
    }
    
    private func animateToastLabel() {
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        textColor = .white
        numberOfLines = 0
        textAlignment = .center
        font = UIFont(name: "Montserrat-Light", size: 14.0)
        alpha = 1.0
        layer.cornerRadius = 10
        clipsToBounds = true
        sizeToFit()
    }
}
