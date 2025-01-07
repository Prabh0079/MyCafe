//
//  PrivacyPolicy.swift
//  MyCafe
//
//  Created by User on 02/01/2025.
//

import SwiftUI

struct PrivacyPolicy: View {
    var body: some View {
        NavigationStack{
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                Text("Privacy Policy")
                    .font(.system(size: 25))
                    .bold()
                
                Text("Last updated: 02/01/2025")
                    .font(.system(size: 15, weight: .bold))
                
                Text("At myCafe,we respect your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and protect your data when you use our app..")
                
                Text("1. Information We Collect") .bold()
                    .font(.system(size: 15, weight: .bold))
                Text("We collect personal information such as your name, email address when you create an account, place an order, or make a reservation. ")
                
                Text("2. Data Sharing") .bold()
                    .font(.system(size: 15, weight: .bold))
                Text("We do not sell, rent, or share your personal data with third parties except where necessary to fulfill your orders")
                
                Text("3. Data Security") .bold()
                    .font(.system(size: 15, weight: .bold))
                Text("We implement industry-standard security measures to protect your personal data from unauthorized access, alteration, or destruction.")
                
                Text("4. Your Rights") .bold()
                    .font(.system(size: 15, weight: .bold))
                Text("You have the right to access, update, or delete your personal data at any time.")
                
                Text("5. Changes to this Policy") .bold()
                    .font(.system(size: 15, weight: .bold))
                Text("We may update this privacy policy occasionally. Any changes will be reflected in the app, and the effective date will be updated..")
                
                Text("Contact Us") .bold()
                    .font(.system(size: 15, weight: .bold))
                Text("If you have any questions or concerns about this Privacy Policy, please contact us at \n 1234567890.")
                
                NavigationLink(destination: SignUp())
                {
                    Text("Back")
                        .foregroundColor(.brown)
                }
                .navigationBarBackButtonHidden(true)
                
            }
            .padding()
        }
      }
    }
}

#Preview {
    PrivacyPolicy()
}
