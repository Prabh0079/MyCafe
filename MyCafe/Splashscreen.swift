//
//  Splashscreen.swift
//  MyCafe
//
//  Created by User on 20/12/2024.
//

import SwiftUI

struct Splashscreen: View {
    var body: some View {
        VStack {
                   Text("\" SIP, RELAX & ENJOY \"")
                       .font(.custom("Menlo", size: 16))
                       .bold()
                       .italic()
            Image(.cafee)
                       .resizable()
                       .scaledToFit()
                       .padding(.top,1)
                       .padding(.bottom,1)
                   Text("my")
                       .font(.system(size: 36))
                       .italic()
                   + Text("Cafe")
                       .bold()
                       .font(.system(size: 36))
                       .italic()
               }
               .frame(width: .infinity, height: .infinity)
           }
       }


#Preview {
    Splashscreen()
}
