//
//  MyCafeApp.swift
//  MyCafe
//
//  Created by User on 19/12/2024.
//

import SwiftUI
import Firebase

@main
struct MyCafeApp: App {

    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
