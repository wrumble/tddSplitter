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
        setupViews()
        setupLayout()
        setupKeyboard()
        bindToast()
        bindButtons()
    }
    
    private func setupHierarchy() {
        view.addSubview(textFieldAndButtonView)
    }
    
    private func setupViews() {
        view.backgroundColor = Color.mainBackground
    }
    
    private func setupLayout() {
        textFieldAndButtonView.pinToSuperviewEdges()
    }
    
    private func registerNewUser(email: String, password: String, confirmationPassword: String) {
        firebaseData.createUser(email: email, password: password, completion: { (error, _ ) in
            if let error = error {
                self.showToast(in: self.view, with: error.localizedDescription)
            } else {
                let successfulRegistraionText = Localized.successfulRegistraionText
                self.showToast(in: self.view, with: successfulRegistraionText)
                self.signInUser(email: email, password: password)
            }
        })
    }
    
    private func signInUser(email: String, password: String) {
        firebaseData.signInUser(email: email, password: password, completion: { (error, splitterUser) in
            if let error = error {
                self.showToast(in: self.view, with: error.localizedDescription)
            } else {
                let successfulLoginText = Localized.successfulLoginText
                self.showToast(in: self.view, with: successfulLoginText)
                self.currentUser = splitterUser
            }
        })
    }
    
    private func bindToast() {
        textFieldAndButtonView.onInvalidTextFieldInput = { [weak self] (text, textField) in
            self?.showToast(in: textField, with: text)
        }
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
