//
//  SwiftUIView.swift
//  MyCafe
//
//  Created by User on 07/01/2025.
//

import SwiftUI

struct EditProfile: View {
    @State var username: String = ""
    @State var email: String = ""
    
    @State var navigateToProfile: Bool = false
    
    @State var sessionManager = SessionManager.shared
    var userService = UserService()
    
    var body: some View {
        NavigationStack{
            VStack {
                Image(.cafee)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    
                Text("Edit Profile")
                    .font(.system(size: 40))
                    .bold()
                
                if let currentUser = sessionManager.getCurrentUser() {
                    
                    TextField("User Name", text: $username)
                        .onAppear {username = currentUser.username}
                        .padding(12)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(10)
                }
                
                TextField("Email address", text: Binding(
                    get: {sessionManager.getCurrentUser()?.email ?? ""},
                    set: {_ in }
                ))
                    .padding(10)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                    .disabled(true)
                
                Button(action:{saveProfile()})
                {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                }
                .padding(.vertical, 15)
                NavigationLink(destination: HomePage(), isActive: $navigateToProfile) {
                    EmptyView()
                }
            }
            .padding()
            .onAppear {
                updatedProfile()
            }
        }
    }
    
    func updatedProfile()
    {
        guard let currentUser = sessionManager.getCurrentUser() else {return}
        username = currentUser.username
    }
    
    func saveProfile()
    {
        guard let currentuser = sessionManager.getCurrentUser() else { return }
        
        if username !=  currentuser.username{
            userService.updateName(userId: currentuser.id, userName: username){ Result in
                switch Result {
                case.success:
                    sessionManager.updateUserInfo(username: username)
                    navigateToProfile = true
                case.failure(let error):
                    print("Error....\(error)")
                }
            }
        } else {
            navigateToProfile = true
        }
    }
}

#Preview {
    EditProfile()
}
