//
//  AppDelegate.swift
//  Splitter
//
//  Created by Wayne Rumble on 21/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = WelcomeScreenViewController()
        window!.makeKeyAndVisible()
        
        return true
    }
    
// Used for testing only
    func resetAppToWelcomeScreen() {
        window?.rootViewController = WelcomeScreenViewController()
    }
    
    func startAtMyBillsVCWithUserEmail(_ email: String) {
        let myBillsViewController = MyBillsViewController()
        let firebaseData = FirebaseData()
        firebaseData.signInUser(email: email,
                                  password: "password",
                                  completion: { ( _, splitterUser) in
                myBillsViewController.currentUser = splitterUser
                self.window?.rootViewController = myBillsViewController
        })
    }

    func startAtNewBillVCWithUserID(_ userID: String) {
        let newBillViewController = NewBillViewController()
        newBillViewController.currentUserID = userID
        window?.rootViewController = newBillViewController
    }
}
