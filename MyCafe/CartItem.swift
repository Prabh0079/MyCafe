//
//  CartItem.swift
//  MyCafe
//
//  Created by User on 14/01/2025.
//

import Foundation

struct CartItem: Identifiable {
    var id: String
    var coffee: CoffeeType
    var quantity: Int
    
    init(id: String = UUID().uuidString, coffee: CoffeeType, quantity: Int) {
        self.id = id
        self.coffee = coffee
        self.quantity = quantity
    }
 
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "coffeeId": coffee.id,
            "coffeeName": coffee.name,
            "coffeePrice": coffee.price,
            "coffeeImage": coffee.imageName,
            "quantity": quantity
        ]
    }
}
