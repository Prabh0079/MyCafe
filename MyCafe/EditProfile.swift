//
//  SwiftUIView.swift
//  MyCafe
//
//  Created by User on 07/01/2025.
//

import SwiftUI
import FirebaseAuth

struct EditProfile: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var navigateToProfile: Bool = false
    @State var alertMsg: String = ""
    @State var showAlert: Bool = false
    @State var moveToSignIn: Bool = false
    @State var isLiggedOut: Bool = false
    
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
                        .padding()
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(10)
                }
                
                TextField("Email address", text: Binding(
                    get: {sessionManager.getCurrentUser()?.email ?? ""},
                    set: {_ in }
                ))
                    .padding()
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
                .padding(.vertical, 20)
                
                NavigationLink(destination: HomePage(), isActive: $navigateToProfile) {
                    EmptyView()
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                
                NavigationLink(destination: ChangePassword()) {
                    Text("Change Password")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .padding(.bottom, 15)
                
                Button(action:{
                    SessionManager.shared.logoutUser()
                    moveToSignIn = true
                }) {
                    Text("Log Out")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                }
                .padding(.bottom, 15)
                
                NavigationLink(destination: SignIn(), isActive: $moveToSignIn) {
                    EmptyView()
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                
                Button(action:{showAlert = true})
                {
                    Text("Delete Profile")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                }
                .alert("Are you sure to delete???", isPresented: $showAlert) {
                    Button("Yes") {
                        userService.deleteProfile()
                        sessionManager.logoutUser()
                        moveToSignIn = true
                    }
                    Button("No", role: .cancel){}
                }
             
                
             
            }
            .padding()
            .onAppear {
                updatedProfile()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    
    func updatedProfile()
    {
        guard let currentUser = sessionManager.getCurrentUser() else {return}
        username = currentUser.username
    }
    
    func saveProfile()
    {
        guard let currentuser = sessionManager.getCurrentUser() else { return }
     //   guard let user = Auth.auth().currentUser else { return }
        
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
    
    func deleteProfile() {
        
    }
    
    func showAlert(message: String) {
        alertMsg = message
        showAlert = true
    }
}

#Preview {
    EditProfile()
}
