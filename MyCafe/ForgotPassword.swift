//
//  ForgotPassword.swift
//  MyCafe
//
//  Created by User on 29/12/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ForgotPassword: View {
    @State var email: String = ""
    @State var showalert: Bool = false
    @State var alertMsg: String = ""
    @State var navigateToSignIn: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(.cafee)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 150, maxHeight: 150)
                
                Text("Reset Password")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom,20)
                
                Text("Enater your email address to receive a link to reset your password")
                    .padding(.bottom,20)
                
                VStack {
                    TextField("Email Address",text: $email)
                            .padding()
                            .background(.gray.opacity(0.5))
                            .cornerRadius(10)
                    
                    Button(action:{resetPassword()}){
                        Text("Reset")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.black.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.top,30)
                    }
                    
                    NavigationLink(destination: SignIn()) {
                        Text("Back to Login")
                            .foregroundColor(.brown)
                            .padding()
                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                }
            }
            .padding()
            .alert(isPresented: $showalert) {
                Alert(
                    title: Text("Notification"),
                    message: Text(alertMsg),
                    dismissButton: .default(Text("Ok"))
                )
            }
        }
    }
    private func resetPassword() {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(message: "Email is required")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                showAlert(message: "Failed to send reset email: \(error.localizedDescription)")
            } else {
                showAlert(message: "Check your email to reset your password")
                navigateToSignIn = true
            }
        }
    }
 
    private func showAlert(message: String) {
        alertMsg = message
        showalert = true
    }
}

#Preview {
    ForgotPassword()
}
