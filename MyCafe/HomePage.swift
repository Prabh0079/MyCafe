//
//  HomePage.swift
//  MyCafe
//
//  Created by User on 07/01/2025.
//

import SwiftUI
import FirebaseAuth

struct HomePage: View {
    @State var userName: String = ""
    @State var sessionManager = SessionManager.shared
    @State var navigateToSignIn: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                let currentUser = sessionManager.getCurrentUser()
                Text(currentUser?.username ?? "")
                Text("Home Page")
                    .font(.system(size: 35))
                    .bold()
                    .padding()
                NavigationLink(destination: EditProfile()) {
                    Text("Edit Profile")
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                
                Button(action:{
                    SessionManager.shared.logoutUser()
                    navigateToSignIn = true})
                {
                    Text("Logout")
                }
                NavigationLink(destination: SignIn(), isActive: $navigateToSignIn) {
                    EmptyView()
                }
                              
            }
        }
    }
}

#Preview {
    HomePage()
}
