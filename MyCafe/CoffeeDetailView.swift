//
//  CoffeeDetailView.swift
//  MyCafe
//
//  Created by User on 14/01/2025.
//

import SwiftUI

struct CoffeeDetailView: View {
    var coffee: CoffeeType
    @State private var quantity: Int = 1
    @ObservedObject var cartManager: CartManager
    @State private var isOrderPlaced = false
    
    var totalPrice: Double {
        return coffee.price * Double(quantity)
    }
    
    var body: some View {
        VStack {
            Image(coffee.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .padding()
            
            Text(coffee.name)
            
            HStack {
                Button(action: {
                    if quantity > 1 {
                        quantity -= 1
                    }
                }) {
                    Text("-")
                        .font(.title)
                        .padding()
                        .frame(width: 50, height: 50)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
                
                Text("\(quantity)")
                    .font(.title)
                    .padding(.horizontal)
                
                Button(action: {
                        quantity += 1
                }) {
                    Text("+")
                        .font(.title)
                        .padding()
                        .frame(width: 50, height: 50)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
            }
            .padding(.top)
            
            Text(String(format: "Total: $%.2f", totalPrice))
                .font(.title2)
                .foregroundColor(.green)
                .padding(.top, 5)
            
            Button(action: {
                cartManager.addToCart(coffee: coffee, quantity: quantity)
                isOrderPlaced = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isOrderPlaced = false
                }
            }){
                Text("Ad to cart")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            Spacer()
        }
        .padding()
        .navigationTitle(coffee.name)
        .navigationBarTitleDisplayMode(.inline)
        
        if isOrderPlaced {
            VStack {
                Spacer()
                
                Text("Item added to the cart..")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: isOrderPlaced)
                    .padding(.bottom, 50)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.3).edgesIgnoringSafeArea(.all))
        }
    }
}

struct CoffeeDetail_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeDetailView(coffee: CoffeeType(name: "Espresso", imageName: "Espresso", price: 2.99), cartManager: CartManager())
    }
}
