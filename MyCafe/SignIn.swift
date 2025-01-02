//
//  SignIn.swift
//  MyCafe
//
//  Created by User on 26/12/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignIn: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isPasswordVisible: Bool = false
    @State var showalert: Bool = false
    @State var AlertMsg: String = ""
    @State var navigateToHomeScreen: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(.cafee)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 150, maxHeight:150)
                    .padding(.top,20)
                Text("my")
                    .font(.system(size: 28))
                    .italic()
                + Text("Cafe")
                    .bold()
                    .font(.system(size: 28))
                    .italic()
                
                Text("Behind every successful person is good amount of coffee. So choose"
                     + " best grains, finest roast, the most powerful flavor....")
                .font(.system(size: 16))
                .padding(.top,10)
                .padding(.horizontal,15)
                
                VStack {
                    TextField("Email Address",text: $email)
                        .padding()
                        .background(.gray.opacity(0.5))
                        .cornerRadius(10)
                    HStack {
                        if isPasswordVisible {
                            TextField("Enter Password",text: $password)
                                .padding()
                        } else {
                            SecureField("Enter Password",text: $password)
                                .padding()
                        }
                        Button(action:{isPasswordVisible.toggle()})
                        {
                            Image(systemName:isPasswordVisible ? "eye" : "eye.slash")
                                .padding()
                                .foregroundColor(.black)
                        }
                    }
                    .background(.gray.opacity(0.5))
                    .cornerRadius(10)
                    
                    HStack {
                        Text("Forgot Password?")
                        NavigationLink(destination: ForgotPassword())
                        {
                            Text("Reset Here..")
                                .foregroundColor(.brown)
                                .underline()
                        }
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                    }
                    Button(action:{loginUser()})
                    {
                        Text("SignIn")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(10)
                    }
                    .padding(.top,50)
                    
                    HStack {
                        Text("First Visit?")
                        NavigationLink(destination: SignUp()) {
                            Text("Register yourself")
                                .foregroundColor(.brown)
                                .underline()
                        }
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                    }
                    Spacer()
                }
                .padding()
            }
            .alert(isPresented: $showalert){
                Alert(
                    title: Text("Invalid Email or Password"),
                    message: Text(AlertMsg),
                    dismissButton: .default(Text("Ok"))
                )
            }
            .fullScreenCover(isPresented: $navigateToHomeScreen)
            {
                Splashscreen()
                    .onDisappear {
                        navigateToHomeScreen = false
                    }
            }
        }
    }
    
    func loginUser() {
        
        if email.isEmpty {
            showAlert(message: "Email is required")
            return
        } else if !Utils.isValidEmail(email)
        {
            showAlert(message: "Invalid email adddress")
            return
        }
        
        if password.isEmpty {
            showAlert(message: "Password is required")
            return
        } else if password.count < 8 {
            showAlert(message: "Password should be more than 8 characters")
            return
        } else if !Utils.isPasswordValid(password) {
            showAlert(message: "Password must contain atleast one letter and digit")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {
            authResult, error in
            if let error = error {
                
                print("Login error: \(error.localizedDescription)")
                self.showAlert(message: error.localizedDescription)
                return
            }
            
            guard let authResult = authResult else {
                self.showAlert(message: "Authentication failed, try later")
                return
            }
            
            let user = authResult.user
            
            if user.isEmailVerified {
                print("User id: \(user.uid)")
                
                SessionManager.shared.loginUser(userId: user.uid) { success in
                    if success {
                        self.navigateToHomeScreen = true
                    } else {
                        SessionManager.shared.logoutUser()
                        self.showAlert(message: "Failed to log in.")
                    }
                }
            } else {
                self.showAlert(message: "Please verify your email before siging in")
            }
        }
    }
    func showAlert(message: String) {
        showalert = true
        AlertMsg = message
    }
}

#Preview {
    SignIn()
}
