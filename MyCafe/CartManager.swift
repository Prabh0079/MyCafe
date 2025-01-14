//
//  CartManager.swift
//  MyCafe
//
//  Created by User on 14/01/2025.
//

import SwiftUI

class CartManager: ObservableObject {
    @Published var cartItems: [CartItem] = []
    
    func addToCart(coffee: CoffeeType, quantity: Int) {
        if let index = cartItems.firstIndex(where: { $0.coffee.id == coffee.id }) {
            cartItems[index].quantity += quantity
        } else {
            let newItem = CartItem(coffee: coffee, quantity: quantity)
            cartItems.append(newItem)
        }
    }
     
    func removeFromCart(item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id}) {
            cartItems.remove(at: index)
        }
    }
}

struct CartItem: Identifiable {
    let id = UUID()
    var coffee: CoffeeType
    var quantity: Int
}
