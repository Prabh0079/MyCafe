//
//  SessionManager.swift
//  MyCafe
//
//  Created by User on 29/12/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    private let userservice = UserService()
    @Published private var currentUser: SessionUsers?
    
    var isLoggedIn: Bool {
        return currentUser != nil
    }
    
    func loginUser(userId:String, completion: @escaping (Bool) -> Void) {
        userservice.fetchUserByUserID(withId: userId) { [weak self] (user) in
            if let user = user {
                self?.currentUser = user
                completion(true)
            } else {
                self?.currentUser = nil
                completion(false)
            }
        }
    }
    func logoutUser() {
        do {
            try Auth.auth().signOut()
            currentUser = nil
        } catch {
            print(error.localizedDescription)
        }
    }
}
