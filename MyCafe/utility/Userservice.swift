//
//  Userservice.swift
//  MyCafe
//
//  Created by User on 23/12/2024.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

enum UserServiceError: Error {
    case uploadError(String)
    case databaseError(String)
}

class UserService: ObservableObject {
     
    private var reference: DatabaseReference
    private var storageReference: StorageReference
    private let _collection = "users"
    
    init() {
        self.reference = Database.database().reference()
        self.storageReference = Storage.storage().reference()
    }
    
    func registerUser(_user: Users, completion: @escaping (Bool) -> Void) {
        reference.child(_collection).child(_user.userId).setValue(_user.toDictionary()) { error, _ in
            if let error = error {
                print("Error Writing user data: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
            
        }
    }
    
}
