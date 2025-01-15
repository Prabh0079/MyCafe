//
//  CartManager.swift
//  MyCafe
//
//  Created by User on 14/01/2025.
//

import Foundation
import FirebaseDatabase

class CartManager: ObservableObject {
    @Published var cartItems: [CartItem] = []
    private var databaseRef: DatabaseReference
    
    init() {
        self.databaseRef = Database.database().reference().child("cartItems")
      }
    
    func addToCart(coffee: CoffeeType, quantity: Int) {
        let newCartItem = CartItem(coffee: coffee, quantity: quantity)
        
        let newItemRef = databaseRef.child(newCartItem.id)
        newItemRef.setValue(newCartItem.toDictionary())
        
        self.cartItems.append(newCartItem)
    }
     
    func removeFromCart(item: CartItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id}) {
            cartItems.remove(at: index)
            
            let itemRef = databaseRef.child(item.id)
            itemRef.removeValue()
        }
    }
    
    func fetchCartItems() {
        databaseRef.observe(.value) { snapshot in
            var fetchedItems: [CartItem] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let cartItemDict = snapshot.value as? [String: Any],
                   let coffeeId = cartItemDict["coffeeId"] as? String,
                   let coffeeName = cartItemDict["coffeeName"] as? String,
                   let coffeePrice = cartItemDict["coffeePrice"] as? Double,
                   let coffeeImage = cartItemDict["coffeeImage"] as? String,
                   let quantity = cartItemDict["quantity"] as? Int {
                    
                    let coffee = CoffeeType(id: coffeeId, name: coffeeName, imageName: coffeeImage, price: coffeePrice)
                    let cartItem = CartItem(id: snapshot.key, coffee: coffee, quantity: quantity)
                    fetchedItems.append(cartItem)
                }
            }
            self.cartItems = fetchedItems
        }
    }
    
    func clearCart() {
        self.cartItems.removeAll()
        self.databaseRef.removeValue()
    }
}

