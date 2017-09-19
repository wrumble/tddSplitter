//
//  NewBillViewController.swift
//  Splitter
//
//  Created by Wayne Rumble on 19/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class NewBillViewController: UIViewController {
    
    var currentUserID: String?
    
    private var titleLabel = TitleLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    private func setupHierarchy() {
        view.addSubview(titleLabel)
    }
    
    private func setupViews() {
        view.backgroundColor = Color.mainBackground
        
        titleLabel.text = Localized.newBillViewControllerTitle
    }
    
    private func setupLayout() {
        titleLabel.pinToSuperview(edges: [.left, .right])
        titleLabel.pinTop(to: view,
                          constant: Layout.titleLabelY,
                          priority: .required,
                          relatedBy: .equal)
    }
    
}
