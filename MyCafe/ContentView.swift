//
//  ContentView.swift
//  MyCafe
//
//  Created by User on 19/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State var showSplash: Bool = true
    var body: some View {
        if showSplash{
            Splashscreen()
                .onAppear(){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                        withAnimation {
                            showSplash = false
                        }
                    }
                }
        } else {
            SignIn()
        }
        
    }
}

#Preview {
    ContentView()
}
