//
//  ChangePassword.swift
//  MyCafe
//
//  Created by User on 07/01/2025.
//

import SwiftUI

struct ChangePassword: View {
    @State var password: String = ""
    @State var isPasswordVisible: Bool = false
    @State var newPassword: String = ""
    @State var isNewPasswordVisible: Bool = false
    @State var confirmNewPassword: String = ""
    @State var isconfirmNewPasswordVisible: Bool = false
    
    var body: some View {
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
                    TextField("New Password", text: $confirmNewPassword)
                } else {
                    SecureField("New Password", text: $confirmNewPassword)
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
            
            Button(action:{})
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
    }
}

#Preview {
    ChangePassword()
}
