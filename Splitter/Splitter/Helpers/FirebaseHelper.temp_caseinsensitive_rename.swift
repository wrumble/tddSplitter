//
//  FireBaseHelper.swift
//  Splitter
//
//  Created by Wayne Rumble on 24/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseHelper {
    
    func uploadImage(imageData: Data, completion: @escaping (_ url: URL) -> Void) {
        let storageRef = Storage.storage().reference().child("receiptImage.jpg")
        _ = storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print(error!)
                return
            }
            completion( metadata.downloadURL()! )
        }
    }
}
