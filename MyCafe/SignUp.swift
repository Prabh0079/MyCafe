//
//  SignUp.swift
//  MyCafe
//
//  Created by User on 20/12/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUp: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmpassword: String = ""
    @State var ispasswordvisible: Bool = false
    @State var isconfirmpasswordvisible: Bool = false
    @State var istermsaccepted: Bool = false
    @State var showalert: Bool = false
    @State var alertMsg: String = ""
    @State var navigateToSignIn: Bool = false
    
    var body: some View {
        NavigationStack {
        VStack {
            Image(.cafee)
                .resizable()
                .frame(maxWidth: 120, maxHeight: 120)
            Text("\" Enjoy Your Drink \"")
                .font(.custom("Snell Roundhand", size: 32))
                .fontWeight(.heavy)
            VStack {
                TextField("User Name", text: $username)
                    .padding()
                    .background(.gray.opacity(0.5))
                    .cornerRadius(10)
                TextField("Email Address", text: $email)
                    .padding()
                    .background(.gray.opacity(0.5))
                    .cornerRadius(10)
                
                HStack {
                    if ispasswordvisible {
                        TextField("Enter Password", text: $password)
                            .padding()
                        
                    } else {
                        SecureField ("Enter Password", text: $password)
                            .padding()
                    }
                    Button(action: {ispasswordvisible.toggle()}) {
                        Image(systemName:ispasswordvisible ? "eye" : "eye.slash")
                            .padding()
                            .font(.system(size: 20))
                            .foregroundStyle(Color.black)
                    }
                }
                .background(.gray.opacity(0.5))
                .cornerRadius(10)
                
                HStack {
                    if isconfirmpasswordvisible {
                        TextField("Confirm Password", text: $confirmpassword)
                            .padding()
                    } else {
                        SecureField ("Confirm Password", text: $confirmpassword)
                            .padding()
                    }
                    Button(action:{isconfirmpasswordvisible.toggle()}){
                        Image(systemName:isconfirmpasswordvisible ? "eye" : "eye.slash")
                            .padding()
                            .font(.system(size: 20))
                            .foregroundStyle(Color.black)
                    }
                }
                .background(.gray.opacity(0.5))
                .cornerRadius(10)
                
                HStack {
                    Button(action:{istermsaccepted.toggle()}){
                        Image(systemName: istermsaccepted  ? "circle.fill" : "circle")
                            .foregroundColor(istermsaccepted ? .brown : .black)
                    }
                    Text("I accept term and conditions")
                }
                .padding()
                
                Button(action: {registerUser()})
                {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                }
                
                HStack {
                    Text("Got a Profile")
                        .italic()
                    
                    NavigationLink(destination: SignIn()){
                        Text("Sign In")
                            .foregroundStyle(.brown)
                            .bold()
                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
                }
                Spacer()
                
                NavigationLink(destination: Splashscreen()) {
                    HStack {
                        Text("By registering, I acknowledge that I have read and accept all terms and conditions of use and the ")
                            .foregroundColor(.black)
                        + Text("Privacy Policy")
                            .foregroundColor(.brown)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
            .padding()
        }
    //.frame(width: .infinity, height: .infinity)
        .alert(isPresented: $showalert)
            {
                Alert(title: Text("Registration Error"),
                      message: Text(alertMsg),
                      dismissButton: .default(Text("Ok")))
            }
            .navigationDestination(isPresented: $navigateToSignIn){
                Splashscreen()
            }
        }
    }
    
    func registerUser()
    {
        showalert = false
        alertMsg = ""
        
        if username.isEmpty {
            showalert(messege: "User Name is required")
            return
        }
        if email.isEmpty {
            showalert(messege: "Email is required")
            return
        }
        if password.isEmpty {
            showalert(messege: "Password is required")
            return
        }
        else if password.count < 8 {
            showalert(messege: "password should be more than 8 characters")
            return
        }
        if confirmpassword.isEmpty {
            showalert(messege: "Please Confirm your password")
            return
        }
        else if confirmpassword != confirmpassword {
            showalert(messege: "Passwords do not match")
            return
        }
        if !istermsaccepted {
            showalert(messege: "Please accept the term and conditions")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                DispatchQueue.main.async {
                    let errorCode = error.code
                    switch errorCode {
                    case AuthErrorCode.emailAlreadyInUse.rawValue:
                        showalert(messege: "The email address is already in use.")
                    case AuthErrorCode.weakPassword.rawValue:
                        showalert(messege: "The password is too weak")
                    default:
                        showalert(messege: error.localizedDescription)
                    }
                }
                return
            }
    
                // Send email
            DispatchQueue.main.async {
                if let user = authResult?.user {
                    user.sendEmailVerification { error in
                        if let error = error {
                            showalert(messege: "Failed to send verification email: \(error.localizedDescription)")
                                                       return
                        }
                        print("send creation Started")
                        
                        let userId = user.uid
                        var newuser = Users.init(userId: userId, username: username, email: email)
                     
                        UserService().registerUser(_user: newuser) { success in
                                               if success {
                                                   showalert(messege: "User registered successfully. Please verify your email.")
                                                   navigateToSignIn = true
                                               } else {
                                                   showalert(messege: "Failed to register user in the system.")
                                               }
                        
                        }
                    }
                }
            }
            
        }
        print("user registered successfully")
    }
    
    func showalert(messege: String)
    {
        alertMsg = messege
        showalert = true
    }
    
}
#Preview {
    SignUp()
}


//struct SignUp_PreViews: PreviewProvider {
//    static var previews: some View {
//        SignUp()
//    }
//}
