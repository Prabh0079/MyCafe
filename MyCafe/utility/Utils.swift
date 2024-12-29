//
//  Utils.swift
//  MyCafe
//
//  Created by User on 23/12/2024.
//

import Foundation

struct Utils
{
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    static func getCurrentDateTime() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateformatter.locale = Locale.current
        return dateformatter.string(from: Date())
    }
}
