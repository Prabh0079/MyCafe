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
                  .font(.system(size: 20))
                  .padding(10)
              
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
                    NavigationLink(destination:Splashscreen())
                    {
                        Text("Reset Here..")
                            .foregroundColor(.brown)
                            .underline()
                    }
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
          .navigationBarBackButtonHidden(true)
          .navigationBarHidden(true)
          .fullScreenCover(isPresented: $navigateToHomeScreen)
            {
                Splashscreen()
                    .onDisappear {
                        navigateToHomeScreen = false
                    }
            }
      }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func showalert(messege: String)
    {
        AlertMsg = messege
        showalert = true
    }
    
    func loginUser() {
        
    }
}

#Preview {
    SignIn()
}
