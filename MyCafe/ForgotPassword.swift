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
                
                VStack {
                    TextField("Email Address",text: $email)
                            .padding()
                            .background(.gray.opacity(0.5))
                            .cornerRadius(10)
                    
                    Button(action:{}){
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
                }
                .padding()
            }
        }
    }
}

#Preview {
    ForgotPassword()
}
