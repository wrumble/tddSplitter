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
    
    func createItem(_ item: Item, completion: @escaping (_ error: Error?, _ result: DatabaseReference?) -> Void) {
        databaseReference.child("Bills").child(item.billID).child("Items").child(item.id).setValue(item.entitiesAsAny()) { (error, result) in
            if let error = error {
                completion(error, result)
            } else {
                completion(error, result)
            }
        }
    }
    
    func removeBill(with id: String, completion: @escaping (_ error: Error?, _ result: DatabaseReference?) -> Void) {
        let billReference = databaseReference.child("Bills").child(id)
        billReference.removeValue { (error, result) in
            if let error = error {
                completion(error, result)
            } else {
                completion(error, result)
            }
        }
    }
    
    func findBill(with id: String, completion: @escaping (_ bill: Bill?) -> Void) {
        let billReference = databaseReference.child("Bills").child(id)
        var bill: Bill?
        billReference.observeSingleEvent(of: .value, with: { snapshot in
            let id = snapshot.childSnapshot(forPath: "id").value!
            let name = snapshot.childSnapshot(forPath: "name").value!
            let date = snapshot.childSnapshot(forPath: "date").value!
            let location = snapshot.childSnapshot(forPath: "location").value!
            let imageURL = snapshot.childSnapshot(forPath: "imageURL").value!
            let itemsSnapshot = snapshot.childSnapshot(forPath: "Items")
            var items = [Item]()
            if let createdItems = self.createItemsArray(itemsSnapshot) {
                items = createdItems
            }
            
            bill = Bill(name: name as! String,
                        date: date as! String,
                        location: location as? String,
                        imageURL: imageURL as! String,
                        items: items)
            bill?.id = id as! String
            
            completion(bill)
        })
    }
    
    func createItemsArray(_ snapshot: DataSnapshot?) -> [Item]? {
        var items = [Item]()
        (snapshot?.children.allObjects as! [DataSnapshot]).forEach { snapshot in
            let id = snapshot.childSnapshot(forPath: "id").value!
            let name = snapshot.childSnapshot(forPath: "name").value!
            let price = snapshot.childSnapshot(forPath: "price").value!
            let creationDate = snapshot.childSnapshot(forPath: "creationDate").value!
            let billID = snapshot.childSnapshot(forPath: "billID").value!
            
            var item = Item(name: name as! String,
                            price: price as! Double,
                            billID: billID as! String)
            item.id = id as! String
            item.createionDate = creationDate as! String
            
            items.append(item)
        }
        
        return items
    }
}
