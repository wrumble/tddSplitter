//
//  MyBillsViewController.swift
//  Splitter
//
//  Created by Wayne Rumble on 01/08/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit
import Firebase
import iCarousel

class MyBillsViewController: UIViewController {
    
    private let addButton = AddButton(accessID: AccesID.addButton)
    private let deleteButton = DeleteButton(accessID: AccesID.deleteButton)
    
    private var userBills = [Bill]()
    private var titleLabel = TitleLabel(accessID: AccesID.titleLabel)
    private var carousel = iCarousel()
    private var carouselDatasource = BillsCarouselDatasource()

    private weak var carouselDelegate = BillsCarouselDelegate()
    
    var currentUser: SplitterUser! {
        didSet {
            self.userBills = getUserBills()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    private func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        view.addSubview(deleteButton)
        view.addSubview(carousel)
    }
    
    private func setupViews() {
        view.backgroundColor = Color.mainBackground
        
        titleLabel.text = Localized.myBillsViewControllerTitle
        
        carouselDatasource.bills = userBills
        carousel.dataSource = carouselDatasource
        carousel.delegate = carouselDelegate
        carousel.isPagingEnabled = true
        carousel.type = .coverFlow
        carousel.backgroundColor = .clear
    }
    
    private func setupLayout() {
        titleLabel.pinToSuperview(edges: [.left, .right])
        titleLabel.pinTop(to: view,
                          constant: Layout.titleLabelY,
                          priority: .required,
                          relatedBy: .equal)
        
        addButton.pinToSuperview(edges: [.left, .bottom])
        
        deleteButton.pinToSuperview(edges: [.right, .bottom])
        
        carousel.pinToSuperviewEdges()
        
    }
    
    private func getUserBills() -> [Bill] {
        let firebaseData = FirebaseData()
        var currentUserBills = [Bill]()
        firebaseData.findBillsWith(userID: currentUser.id,
                                   completion: { bills in
                                    
            if let bills = bills {
                currentUserBills = bills
            }
                                    
        })
        
        return currentUserBills
    }
}
