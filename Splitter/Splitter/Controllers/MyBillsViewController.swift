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
    
    private let addButton = IconButton(accessID: AccesID.addButton,
                                      iconImage: Image.addButton!)
    private let deleteButton = IconButton(accessID: AccesID.deleteButton,
                                            iconImage: Image.deleteButton!)

    private let noBillsLabel = InstructionLabel()
    private let titleLabel = TitleLabel()
    private let carousel = iCarousel()
    private let carouselDatasource = BillCarouselDatasource()

    private weak var carouselDelegate = BillCarouselDelegate()
    
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
        view.addSubview(carousel)
        view.addSubview(deleteButton)
        view.addSubview(noBillsLabel)

    }
    
    private func setupViews() {
        view.backgroundColor = Color.mainBackground
        
        titleLabel.text = Localized.myBillsViewControllerTitle
        
        addButton.addTarget(self, action: #selector(addButtonWasTapped), for: .touchUpInside)
        
        carousel.dataSource = carouselDatasource
        carousel.delegate = carouselDelegate
        carousel.isPagingEnabled = true
        carousel.type = .coverFlow
        carousel.backgroundColor = .clear
        
        deleteButton.isHidden = true
        
        noBillsLabel.text = Localized.noBillsMessage
        noBillsLabel.isHidden = true
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
        
        carousel.pinTop(to: titleLabel,
                        anchor: .bottom,
                        constant: Layout.spacer,
                        priority: .required,
                        relatedBy: .equal)
        carousel.pinToSuperviewLeft(withConstant: Layout.spacer,
                                    priority: .required,
                                    relatedBy: .equal)
        carousel.pinToSuperviewRight(withConstant: -Layout.spacer,
                                    priority: .required,
                                    relatedBy: .equal)
        carousel.pinBottom(to: addButton,
                           anchor: .top,
                           constant: Layout.spacer,
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
        let firebaseData = FirebaseData()
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
        })
    }
    
    @objc private func addButtonWasTapped() {
        let newBillViewController = NewBillViewController(currentUser: currentUser!)
        present(newBillViewController, animated: false)
    }
}
