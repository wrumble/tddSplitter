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
    
    private var currentUser: SplitterUser? {
        didSet {
            let nextViewController = MyBillsViewController()
            nextViewController.currentUser = self.currentUser
            present(nextViewController, animated: true)
        }
    }
    
    private let firebaseData = FirebaseData()
    private let textFieldAndButtonView = WelcomeScreenInformationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupKeyboard()
        bindButtons()
        view.backgroundColor = Color.mainBackground
    }
    
    private func setupHierarchy() {
        view.addSubview(textFieldAndButtonView)
    }
    
    private func setupLayout() {
        textFieldAndButtonView.pinToSuperviewEdges()
    }
    
    private func registerNewUser(email: String, password: String, confirmationPassword: String) {
        
        if password == confirmationPassword {
            firebaseData.createUser(email: email, password: password, completion: { (error, _ ) in
                if let error = error {
                    //raise error
                    print(error)
                } else {
                    self.signInUser(email: email, password: password)
                }
            })
        } else {
            //raise password mismatch error
            print("password mismatch error")
        }
    }
    
    private func signInUser(email: String, password: String) {

        firebaseData.signInUser(email: email, password: password, completion: { (error, splitterUser) in
            if let error = error {
                //raise error
                print(error)
            } else {
                self.currentUser = splitterUser
            }
        })
    }
    
    private func bindButtons() {
        textFieldAndButtonView.onLogin = { [weak self] (email, password) in
            self?.signInUser(email: email, password: password)
        }
        textFieldAndButtonView.onRegister = { [weak self] (email, password, confirmationPassword) in
            self?.registerNewUser(email: email, password: password, confirmationPassword: confirmationPassword)
        }
    }
}

extension WelcomeScreenViewController {
    func setupKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo,
            let keyBoardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyBoardHeight = keyBoardFrame.cgRectValue.height
                textFieldAndButtonView.moveViewUpWithKeyboard(height: keyBoardHeight)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        textFieldAndButtonView.moveViewDownWithKeyboard()
    }
}


