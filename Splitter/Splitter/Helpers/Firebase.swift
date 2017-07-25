//
//  FireBaseHelper.swift
//  Splitter
//
//  Created by Wayne Rumble on 24/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseStorage {
    
    func uploadImage(billId: String, imageData: Data, completion: @escaping (_ imageURL: URL?) -> Void) {
        let storageReference = Storage.storage().reference().child("BillImages").child(billId)
        storageReference.putData(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print(error!)
                return
            }
            completion( metadata.downloadURL()?.absoluteURL )
        }
    }
}

struct FirebaseData {
    
    let databaseReference = Database.database().reference()
    
    func createBill(_ bill: Bill, completion: @escaping (_ error: Error?, _ result: DatabaseReference?) -> Void) {
        databaseReference.child("Bills").child(bill.id).setValue(bill.entitiesAsAny()) { (error, result) in
            if let error = error {
                completion(error, result)
            } else {
                completion(error, result)
            }
        }
    }
    
    func removeBill(withID id: String, completion: @escaping (_ error: Error?, _ result: DatabaseReference?) -> Void) {
        let billReference = databaseReference.child("Bills").child(id)
        billReference.removeValue { (error, result) in
            if let error = error {
                completion(error, result)
            } else {
                completion(error, result)
            }
        }
    }
    
    func findBill(withID id: String, completion: @escaping (_ bill: Bill?) -> Void) {
        let billReference = databaseReference.child("Bills").child(id)
        var bill: Bill?
        billReference.observe(.value, with: { snapshot in
            let id = snapshot.childSnapshot(forPath: "id").value! as! String
            let name = snapshot.childSnapshot(forPath: "name").value! as! String
            let date = snapshot.childSnapshot(forPath: "date").value! as! String
            let location = snapshot.childSnapshot(forPath: "location").value! as! String
            let imageURL = snapshot.childSnapshot(forPath: "imageURL").value! as! String
            
            bill = Bill(name: name, date: date, location: location, imageURL: imageURL)
            bill?.id = id
        })
        completion(bill)
    }
}
