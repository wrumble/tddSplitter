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

    private let noBillsLabel = NoBillsLabel()
    private var titleLabel = TitleLabel()
    private var carousel = iCarousel()
    private var carouselDatasource = BillCarouselDatasource()

    private weak var carouselDelegate = BillCarouselDelegate()
    
    var currentUser: SplitterUser! {
        didSet {
            getUserBills()
        }
    }
    
    private var userBills: [Bill]? {
        didSet {
            carouselDatasource.bills = userBills!
            carousel.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupViews()
        setupLayout()
    }
    
    private func setupHierarchy() {
        view.addSubview(carousel)
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        view.addSubview(deleteButton)
        view.addSubview(noBillsLabel)

    }
    
    private func setupViews() {
        view.backgroundColor = Color.mainBackground
        
        carousel.dataSource = carouselDatasource
        carousel.delegate = carouselDelegate
        carousel.isPagingEnabled = true
        carousel.type = .coverFlow
        carousel.backgroundColor = .clear
        
        titleLabel.text = Localized.myBillsViewControllerTitle
        
        addButton.addTarget(self, action: #selector(addButtonWasTapped), for: .touchUpInside)
        
        deleteButton.isHidden = true
        
        noBillsLabel.text = Localized.noBillsMessage
        noBillsLabel.isHidden = true
    }
    
    private func setupLayout() {
        carousel.pinToSuperviewEdges()
        
        titleLabel.pinToSuperview(edges: [.left, .right])
        titleLabel.pinTop(to: view,
                          constant: Layout.titleLabelY,
                          priority: .required,
                          relatedBy: .equal)
        
        addButton.pinToSuperview(edges: [.left, .bottom])
        
        deleteButton.pinToSuperview(edges: [.right, .bottom])
        
        noBillsLabel.pinToSuperview(edges: [.left, .right])
        noBillsLabel.centerXToSuperview()
        noBillsLabel.centerYToSuperview()
    }
    
    private func getUserBills() {
        let firebaseData = FirebaseData()
        firebaseData.findBillsWith(userID: currentUser.id,
                                   completion: { bills in
            if let userbills = bills {
                self.userBills = userbills
                self.hideNoBillsLabel()
                self.showDeleteButton()
            } else {
                self.showNoBillsLabel()
                self.hideDeleteButton()
            }
        })
    }
    
    private func showDeleteButton() {
        DispatchQueue.main.async { [weak self] in
            self?.deleteButton.isHidden = false
        }
    }
    
    private func hideDeleteButton() {
        DispatchQueue.main.async { [weak self] in
            self?.deleteButton.isHidden = true
        }
    }
    
    private func showNoBillsLabel() {
        DispatchQueue.main.async { [weak self] in
            self?.noBillsLabel.isHidden = false
        }
    }
    
    private func hideNoBillsLabel() {
        DispatchQueue.main.async { [weak self] in
            self?.noBillsLabel.isHidden = true
        }
    }
    
    @objc private func addButtonWasTapped() {
        let newBillViewController = NewBillViewController()
        newBillViewController.currentUserID = currentUser.id
        present(newBillViewController, animated: false)
    }
}
