//
//  MyBillsViewController.swift
//  Splitter
//
//  Created by Wayne Rumble on 01/08/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit
import Firebase

class MyBillsViewController: UIViewController {
    
    private let addButton = AddButton(accessID: AccesID.addButton)
    private let deleteButton = DeleteButton(accessID: AccesID.deleteButton)
    
    private var titleLabel = TitleLabel(accessID: AccesID.titleLabel)
    
    var currentUser: SplitterUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupHierarchy()
        setupViews()
        setupLayout()
        getUserBills()
    }
    
    private func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        view.addSubview(deleteButton)
    }
    
    private func setupViews() {
        view.backgroundColor = Color.mainBackground
        
        titleLabel.text = Localized.myBillsViewControllerTitle
    }
    
    private func setupLayout() {
        titleLabel.pinToSuperview(edges: [.left, .right])
        titleLabel.pinTop(to: view,
                          constant: Layout.titleLabelY,
                          priority: .required,
                          relatedBy: .equal)
        
        addButton.pinToSuperview(edges: [.left, .bottom])
        
        deleteButton.pinToSuperview(edges: [.right, .bottom])
    }
    
    private func getUserBills() {
        
    }
}
