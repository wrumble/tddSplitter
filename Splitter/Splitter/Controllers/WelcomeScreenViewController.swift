//
//  WelcomeScreenViewController.swift
//  Splitter
//
//  Created by Wayne Rumble on 21/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit
import Firebase

class WelcomeScreenViewController: UIViewController {
    
    let emailTextField = SplitterTextField(frame: CGRect.zero, accessID: AccesID.emailTextField)
    let passwordTextField = SplitterTextField(frame: CGRect.zero, accessID: AccesID.passwordTextField)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.addSubview(emailTextField)
        
        emailTextField.pinToSuperview(edges: [.left, .right])
        emailTextField.centerYToSuperview()
        emailTextField.addHeightConstraint(with: Layout.textFieldHeight)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(passwordTextField)
        
        passwordTextField.pinToSuperview(edges: [.left, .right])
        passwordTextField.pinTop(to: emailTextField, constant: Layout.textFieldHeight, priority: .required, relatedBy: .equal)
        passwordTextField.addHeightConstraint(with: Layout.textFieldHeight)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
