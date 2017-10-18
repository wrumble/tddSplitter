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
    
    func uploadImage(billId: String,
                     imageData: Data,
                     completion: @escaping (_ imageURL: URL?) -> Void) {
        let storageReference = Storage.storage().reference()
                                                .child("BillImages")
                                                .child(billId)
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
    
    let databaseReference = Database.database().reference().child("Bills")
    
    func createUser(email: String,
                    password: String,
                    completion: @escaping (_ error: Error?, _ splitterUser: SplitterUser?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            completion(error, self.createSplitterUser(from: user))
        })
    }
    
    func signInUser(email: String,
                    password: String,
                    completion: @escaping (_ error: Error?, _ user: SplitterUser?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            completion(error, self.createSplitterUser(from: user))
        })
    }
    
    func signOutUser(completion: @escaping (_ signedOut: Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch let error {
            print("Error logging out: \(error)")
            completion(false)
        }
    }
    
    func createBill(_ bill: Bill,
                    completion: @escaping (_ error: Error?) -> Void) {
        databaseReference.child(bill.id)
                         .setValue(bill.toJSON()) { (error, _) in
            completion(error)
        }
    }
    
    func createItem(_ item: Item,
                    completion: @escaping (_ error: Error?) -> Void) {
        databaseReference.child(item.billID)
                         .child("Items")
                         .child(item.id)
                         .setValue(item.toJSON()) { (error, _) in
            completion(error)
        }
    }
    
    func removeBill(with id: String,
                    completion: @escaping (_ error: Error?) -> Void) {
        let billReference = databaseReference.child(id)
        billReference.removeValue { (error, _) in
            completion(error)
        }
    }
    
    func removeItem(_ item: Item,
                    completion: @escaping (_ error: Error?) -> Void) {
        let itemReference = databaseReference.child(item.billID)
                                             .child("Items")
                                             .child(item.id)
        itemReference.removeValue { (error, _) in
                completion(error)
        }
    }
    
    func findBill(with id: String,
                  completion: @escaping (_ bill: Bill?) -> Void) {
        let billReference = databaseReference.child(id)
        billReference.observeSingleEvent(of: .value, with: { snapshot in
            let bill = self.createBill(from: snapshot)
            completion(bill)
        })
    }
    
    func findBillsWith(userID: String,
                       completion: @escaping (_ bills: [Bill]?) -> Void) {
        databaseReference.queryOrdered(byChild: "userID")
                         .queryEqual(toValue: userID)
                         .observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                let bills = self.createBillsArray(snapshot)
                completion(bills)
            } else {
                completion(nil)
            }
        })
    }
    
    func findItem(_ item: Item,
                  completion: @escaping (_ Item: Item?) -> Void) {
        let itemReference = databaseReference.child(item.billID)
                                             .child("Items")
                                             .child(item.id)
        itemReference.observeSingleEvent(of: .value,
                                         with: { snapshot in
            let item = self.createItem(from: snapshot)
            completion(item)
        })
    }
    
    func createSplitterUser(from firebaseUser: User?) -> SplitterUser? {
        if let firebaseUser = firebaseUser {
            let id = firebaseUser.uid
            let email = firebaseUser.email
            let splitterUser = SplitterUser(id: id,
                                            email: email!)
            
            return splitterUser
        } else {
            return nil
        }
    }
    
    private func createItem(from snapshot: DataSnapshot) -> Item {
        let id = snapshot.childSnapshot(forPath: "id").value!
        let name = snapshot.childSnapshot(forPath: "name").value!
        let price = snapshot.childSnapshot(forPath: "price").value!
        let creationDate = snapshot.childSnapshot(forPath: "creationDate").value!
        let billID = snapshot.childSnapshot(forPath: "billID").value!
        
        var item = Item(name: name as! String,
                        price: price as! String,
                        billID: billID as! String)
        item.id = id as! String
        item.creationDate = creationDate as! String
        
        return item
    }
    
    private func createBill(from snapshot: DataSnapshot) -> Bill {
        let id = snapshot.childSnapshot(forPath: "id").value!
        let userID = snapshot.childSnapshot(forPath: "userID").value!
        let name = snapshot.childSnapshot(forPath: "name").value!
        let location = snapshot.childSnapshot(forPath: "location").value!
        let imageURL = snapshot.childSnapshot(forPath: "imageURL").value!
        let itemsSnapshot = snapshot.childSnapshot(forPath: "items")
        var items = [Item]()
        
        if let createdItems = self.createItemsArray(itemsSnapshot) {
            items = createdItems
        }
        
        var bill = Bill(id: id as! String,
                        userID: userID as! String,
                        name: name as! String,
                        location: location as? String,
                        imageURL: imageURL as! String,
                        items: items)
        bill.id = id as! String
        
        return bill
    }
    
    private func createBillsArray(_ snapshot: DataSnapshot?) -> [Bill]? {
        var bills = [Bill]()
        (snapshot?.children.allObjects as! [DataSnapshot]).forEach { snapshot in
            let bill = self.createBill(from: snapshot)
            bills.append(bill)
        }
        
        return bills
    }

    private func createItemsArray(_ snapshot: DataSnapshot?) -> [Item]? {
        var items = [Item]()
        (snapshot?.children.allObjects as! [DataSnapshot]).forEach { snapshot in
            let item = self.createItem(from: snapshot)
            items.append(item)
        }
        
        return items
    }
}
