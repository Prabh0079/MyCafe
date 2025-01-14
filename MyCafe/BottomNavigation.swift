//
//  BottomNavigation.swift
//  MyCafe
//
//  Created by User on 13/01/2025.
//

import SwiftUI

struct BottomNavigation: View {
    @State public var selectionTab: Int
    
    var body: some View {
        TabView(selection: $selectionTab) {
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
            
            EditProfile()
                .tabItem {
                    Image(systemName: "cart")
                }
                .tag(1)
            
            EditProfile()
                .tabItem {
                    Image(systemName: "gear")
                }
                .tag(2)
        }
        .accentColor(.brown)
    }
}


