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
    var bio: String?
    var creation = Utils.getCurrentDateTime()
    var profilepicture: String?
    var notification = false
    
    func toDictionary() -> [String: Any] {
        return [
            "userId": userId,
            "username": username,
            "email": email,
            "bio": bio ?? "",
            "creation": creation,
            "profilepicture": profilepicture,
            "notification": notification
        ]
    }
}
struct SessionUsers : Identifiable,Codable {
        var id: String
        var username: String
        var email: String
        var bio: String
        var profilepicture: String?
        var notification = false
     
}
