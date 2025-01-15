//
//  CartView.swift
//  MyCafe
//
//  Created by User on 14/01/2025.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
  //  @State private var showAlert = false
    @State private var totalAmount: Double = 0.0
    @State private var showModal = false
    
    var body: some View {
        VStack {
            if cartManager.cartItems.isEmpty {
                Text("Your cart is empty")
                    .font(.title)
                    .padding()
            } else {
                List {
                    ForEach(cartManager.cartItems) { item in
                        HStack {
                            Image(item.coffee.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                                .padding(.trailing)
                            
                            VStack(alignment: .leading) {
                                Text(item.coffee.name)
                                    .font(.headline)
                                Text("Quantity: \(item.quantity)")
                                    .font(.subheadline)
                                Text(String(format: "$%.2f", item.coffee.price * Double(item.quantity)))
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                            }
                            Spacer()
                            Button(action: {cartManager.removeFromCart(item: item)})
                            {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .padding()
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            VStack(alignment: .leading) {
                Text("Total: $\(String(format: "%.2f", cartManager.cartItems.reduce(0) { $0 + $1.coffee.price * Double($1.quantity) }))")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.top)
                
                Button(action: {
                    showModal = true
                    totalAmount = cartManager.cartItems.reduce(0) { $0 + $1.coffee.price * Double($1.quantity) }
                    cartManager.clearCart()
                }) {
                    Text("Confirm Order")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
        }
        .padding()
        .navigationTitle("Cart")
        .onAppear {
            cartManager.fetchCartItems()
        }
        .overlay(
            ZStack {
                if showModal {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showModal = false
                        }
                    VStack(spacing: 20) {
                        Text("Ordered Confirmed")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.brown)
                        
                        Text("Thank you for your order.. Enjoy your coffee..")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Text("Total Amount: $\(String(format: "%.2f", totalAmount))")
                            .font(.title2)
                            .foregroundColor(.green)
                            .padding(.top)
                        
                        Button(action: {
                            showModal = false
                        }) {
                            Text("Ok")
                                .font(.title2)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.top)
                        .frame(width:200)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .frame(width: 300)
                }
            }
        )
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
