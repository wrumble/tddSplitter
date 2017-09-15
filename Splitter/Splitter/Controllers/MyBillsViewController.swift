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
    
    var titleLabel = UILabel()
    var currentUser: SplitterUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        titleLabel.text = Localized.myBillsViewControllerTitle
        titleLabel.frame = view.frame
        titleLabel.textAlignment = .center
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
    }
}
