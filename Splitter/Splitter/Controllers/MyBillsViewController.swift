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
    
    private let firebaseData = FirebaseData()
    
    private let addButton = IconButton(accessID: AccesID.addButton,
                                      iconImage: Image.addButton!)
    private let logoutButton = IconButton(accessID: AccesID.logoutButton,
                                          iconImage: Image.logoutButton!)
    private let deleteButton = IconButton(accessID: AccesID.deleteButton,
                                            iconImage: Image.deleteButton!)

    private let noBillsLabel = InstructionLabel()
    private let titleLabel = TitleLabel()
    private let carousel = iCarousel()
    private let carouselDatasource = CarouselDataSource()
    private let activityIndicator = ActivityIndicator(text: Localized.loadingMessage)
    
    private var userBills: [Bill]? {
        didSet {
            carouselDatasource.bills = userBills!
            carousel.reloadData()
        }
    }
    
    private var currentUser: SplitterUser! {
        didSet {
            getUserBills()
        }
    }
    
    required init(currentUser: SplitterUser) {
        super.init(nibName: nil, bundle: nil)
        defer {
            self.currentUser = currentUser
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        view.addSubview(logoutButton)
        view.addSubview(carousel)
        view.addSubview(deleteButton)
        view.addSubview(activityIndicator)
        view.addSubview(noBillsLabel)
    }
    
    private func setupViews() {
        view.backgroundColor = Color.mainBackground
        
        titleLabel.text = Localized.myBillsViewControllerTitle
        
        addButton.addTarget(self,
                            action: #selector(addButtonWasTapped),
                            for: .touchUpInside)
        
        logoutButton.addTarget(self,
                               action: #selector(logoutButtonWasTapped),
                               for: .touchUpInside)
        
        carousel.dataSource = carouselDatasource
        carousel.isPagingEnabled = true
        carousel.type = .coverFlow
        carousel.backgroundColor = .clear
        
        deleteButton.hide()
        
        activityIndicator.hide()
        
        noBillsLabel.text = Localized.noBillsMessage
        noBillsLabel.hide()
    }
    
    private func setupLayout() {
        titleLabel.pinToSuperview(edges: [.left, .right])
        titleLabel.pinTop(to: view,
                          constant: Layout.titleLabelY,
                          priority: .required,
                          relatedBy: .equal)
        
        addButton.pinToSuperview(edges: [.left, .bottom])
        addButton.addHeightConstraint(with: Layout.addButtonHeightWidth)
        addButton.addWidthConstraint(with: Layout.addButtonHeightWidth)
        
        logoutButton.pinToSuperviewBottom(withConstant: 0,
                                          priority: .required,
                                          relatedBy: .equal)
        logoutButton.centerXToSuperview()
        logoutButton.addHeightConstraint(with: Layout.logoutButtonHeightWidth)
        logoutButton.addWidthConstraint(with: Layout.logoutButtonHeightWidth)
        
        carousel.pinTop(to: titleLabel,
                        anchor: .bottom,
                        constant: Layout.screenEdgeSpacer,
                        priority: .required,
                        relatedBy: .equal)
        carousel.pinToSuperviewLeft(withConstant: Layout.screenEdgeSpacer,
                                    priority: .required,
                                    relatedBy: .equal)
        carousel.pinToSuperviewRight(withConstant: -Layout.screenEdgeSpacer,
                                    priority: .required,
                                    relatedBy: .equal)
        carousel.pinBottom(to: logoutButton,
                           anchor: .top,
                           constant: 0,
                           priority: .required,
                           relatedBy: .equal)
        
        deleteButton.pinToSuperview(edges: [.right, .bottom])
        deleteButton.addHeightConstraint(with: Layout.deleteButtonHeightWidth)
        deleteButton.addWidthConstraint(with: Layout.deleteButtonHeightWidth)
        
        noBillsLabel.pinToSuperview(edges: [.left, .right])
        noBillsLabel.centerXToSuperview()
        noBillsLabel.centerYToSuperview()
    }
    
    private func getUserBills() {
        activityIndicator.show()
        firebaseData.findBillsWith(userID: currentUser.id,
                                   completion: { bills in
            if let userbills = bills {
                self.userBills = userbills
                self.noBillsLabel.hide()
                self.deleteButton.show()
            } else {
                self.noBillsLabel.show()
                self.deleteButton.hide()
            }
            self.activityIndicator.hide()
        })
    }
    
    @objc private func addButtonWasTapped() {
        let newBillViewController = NewBillViewController(currentUser: currentUser!)
        view.window?.rootViewController = newBillViewController
    }
    
    @objc private func logoutButtonWasTapped() {
        firebaseData.signOutUser(completion: { successful in
            if successful {
                let welcomeScreenViewController = WelcomeScreenViewController()
                self.view.window?.rootViewController = welcomeScreenViewController
            }
        })
    }
}
