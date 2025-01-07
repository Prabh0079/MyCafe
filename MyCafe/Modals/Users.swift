//
//  Untitled.swift
//  MyCafe
//
//  Created by User on 23/12/2024.
//

import Foundation

struct Users: Identifiable, Decodable {
    var id: String {
        userId
    }
    var userId: String
    var username: String
    var email: String
    var creation = Utils.getCurrentDateTime()
    var notification = false
    
    func toDictionary() -> [String: Any] {
        return [
            "userId": userId,
            "username": username,
            "email": email,
            "creation": creation,
            "notification": notification
        ]
    }
}
struct SessionUsers : Identifiable,Codable {
        var id: String
        var username: String
        var email: String
        var notification = false
     
}
