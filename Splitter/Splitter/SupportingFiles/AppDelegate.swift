//
//  AppDelegate.swift
//  Splitter
//
//  Created by Wayne Rumble on 21/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit
import Firebase
import LifetimeTracker

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        LifetimeTracker.setup(onUpdate: LifetimeTrackerDashboardIntegration().refreshUI)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        checkUserLoginStatus()
        
        return true
    }
    
    private func checkUserLoginStatus() {
        Auth.auth().addStateDidChangeListener { _, user in
            if let user = user {
                let firebaseData = FirebaseData()
                let splitterUser = firebaseData.createSplitterUser(from: user)
                self.window!.rootViewController = MyBillsViewController(currentUser: splitterUser!)
            } else {
                self.window!.rootViewController = WelcomeScreenViewController()
            }
            self.window!.makeKeyAndVisible()
        }
    }
    
// Used for testing only
    func resetAppToWelcomeScreen() {
        window?.rootViewController = WelcomeScreenViewController()
    }
    
    func startAtMyBillsVCWithUserEmail(_ email: String) {
        checkUserLoginStatus()
        let firebaseData = FirebaseData()
        firebaseData.signInUser(email: email,
                                  password: "password",
                                  completion: { ( _, splitterUser) in
                let myBillsViewController = MyBillsViewController(currentUser: splitterUser!)
                self.window?.rootViewController = myBillsViewController
        })
    }

    func startAtNewBillVCWithUserID(_ user: SplitterUser) {
        let newBillViewController = NewBillViewController(currentUser: user)
        window?.rootViewController = newBillViewController
    }
}
