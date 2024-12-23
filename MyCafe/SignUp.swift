//
//  SignUp.swift
//  MyCafe
//
//  Created by User on 20/12/2024.
//

import SwiftUI

struct SignUp: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmpassword: String = ""
    @State var ispasswordvisible: Bool = false
    @State var isconfirmpasswordvisible: Bool = false
    @State var istermsaccepted: Bool = false
    
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
                            .font(.system(size: 25))
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
                            .font(.system(size: 25))
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
                
                Button(action:{})
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
                    NavigationLink(destination: Splashscreen()){
                        Text("Sign In")
                            .foregroundStyle(.brown)
                            .bold()
                    }
                }
            }
            .padding()
        }
      }
    }
}

#Preview {
    SignUp()
}
