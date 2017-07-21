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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "receipt1")
        let imageData = UIImageJPEGRepresentation(image!, 0.8)!
        
        uploadImage(imageData: imageData, completion: { imageURL in
            let bill = Bill(name: "Bob Ross", date: self.dateAsString(), location: "MacDonalds", imageURL: imageURL!)
            let billRef = Database.database().reference()
            
            billRef.setValue(bill.entitiesAsAny())
        })
    }
    
    private func dateAsString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy HH:mm"
        
        return formatter.string(from: date)
    }
    
    private func uploadImage(imageData: Data, completion: @escaping (_ url: String?) -> Void) {
        let storageRef = Storage.storage().reference().child("receiptImage.jpg")
        _ = storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print(error!)
                return
            }
            completion( metadata.downloadURL()?.absoluteString )
        }
    }
}
