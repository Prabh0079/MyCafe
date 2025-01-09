//
//  ChangePassword.swift
//  MyCafe
//
//  Created by User on 07/01/2025.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ChangePassword: View {
    @State var password: String = ""
    @State var isPasswordVisible: Bool = false
    @State var newPassword: String = ""
    @State var isNewPasswordVisible: Bool = false
    @State var confirmNewPassword: String = ""
    @State var isconfirmNewPasswordVisible: Bool = false
    @State var moveToSignIn: Bool = false
    @State var showAlert: Bool = false
    @State var alertMsg: String = ""
    
    var body: some View {
        NavigationStack{
            VStack {
                Image(.cafee)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                Text("Change Password")
                    .font(.system(size: 35))
                    .bold()
                
                HStack {
                    if isPasswordVisible {
                        TextField("Current Password", text: $password)
                    } else {
                        SecureField("Current Password", text: $password)
                    }
                    Button(action:{isPasswordVisible.toggle()})
                    {
                        Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                            .foregroundColor(.black)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                
                HStack {
                    if isNewPasswordVisible {
                        TextField("New Password", text: $newPassword)
                    } else {
                        SecureField("New Password", text: $newPassword)
                    }
                    Button(action:{isNewPasswordVisible.toggle()})
                    {
                        Image(systemName: isNewPasswordVisible ? "eye" : "eye.slash")
                            .foregroundColor(.black)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                
                HStack {
                    if isconfirmNewPasswordVisible {
                        TextField("Confirm New Password", text: $confirmNewPassword)
                    } else {
                        SecureField("Confirm New Password", text: $confirmNewPassword)
                    }
                    Button(action:{isconfirmNewPasswordVisible.toggle()})
                    {
                        Image(systemName: isconfirmNewPasswordVisible ? "eye" : "eye.slash")
                            .foregroundColor(.black)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                
                Button(action:{changePass()})
                {
                    Text("Change Password")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                }
                .padding(.vertical, 15)
            }
            .padding()
            .alert(alertMsg, isPresented: $showAlert) {
                Button("Ok", role: .cancel) {}
            }
            
            NavigationLink(destination: SignIn(), isActive:  $moveToSignIn)
            {
                EmptyView()
            }
        }
     
    }
    
    func showAlert(message: String) {
        alertMsg = message
        showAlert = true
    }
    
    func changePass() {
        guard let user = Auth.auth().currentUser else { return }
        
        if password.isEmpty {
            showAlert(message: "Current password is required")
            return
        }
        
        if newPassword.isEmpty {
            showAlert(message: "Current password is required")
            return
        } else if newPassword.count < 8 {
            showAlert(message: "Give a strong Password")
            return
        } else if !Utils.isPasswordValid(newPassword) {
            showAlert(message: "Give a strong Password")
            return
        }
        
        if confirmNewPassword.isEmpty {
            showAlert(message: "Confirm new password")
            return
        } else if confirmNewPassword != newPassword {
            showAlert(message: "Passwords should match")
            return
        }
        
        let credentials = EmailAuthProvider.credential(withEmail: user.email!, password: password)
        
        user.reauthenticate(with: credentials) {(result, error) in
            if let error = error {
                showAlert(message: error.localizedDescription)
                return
            }
            
            user.updatePassword(to: newPassword) { error in
                if let error = error {
                    showAlert(message: error.localizedDescription)
                }
                    else {
                        showAlert(message: "Password changed successfully, login again with new password")
                    }
                
                do {
                    try Auth.auth().signOut()
                    SessionManager.shared.logoutUser()
                    moveToSignIn = true
                } catch {
                    showAlert(message: error.localizedDescription)
                }
            }
            
        }
    }
}

#Preview {
    ChangePassword()
}
