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
    func fetchUserByUserID(withId id: String, completion: @escaping(SessionUsers?) -> Void) {
        let userRef = reference.child(_collection)
        
        userRef.child(id)
            .observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    print("SnapShot exists \(snapshot)")
                    
                    if let userData = snapshot.value as? [String: Any]
                    {
                        let isProfileDeleted = userData["Profile Deleted"] as? Bool ?? false
                        
                        if !isProfileDeleted {
                            let username = userData["username"] as? String ?? ""
                            let email = userData["email"] as? String ?? ""
                            let notification = userData["notification"] as? Bool ?? true
                            
                            let user = SessionUsers(id: id,
                                                    username: username,
                                                    email: email
                                                )
                            completion(user)
                        } else {
                            print("No user found")
                            completion(nil)
                        }
                    } else {
                        print("Failed to parse for: \(id)")
                        completion(nil)
                    }
                } else {
                    print("No user found for:\(id)")
                    completion(nil)
                }
            }
    }
    
    func updateName(userId: String, userName: String, completion: @escaping(Result<Void, UserServiceError>)  -> Void) {
        let updates: [String: Any] = [
            "username": userName
        ]
        reference.child(_collection).child(userId).updateChildValues(updates) { error, _ in
            if let error = error {
                completion(.failure(.databaseError(error.localizedDescription)))
            } else {
                completion(.success(()))
            }
        }
    }
    
}
