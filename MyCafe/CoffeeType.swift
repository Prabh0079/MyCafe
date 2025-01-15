//
//  CoffeeType.swift
//  MyCafe
//
//  Created by User on 14/01/2025.
//


import Foundation

struct CoffeeType: Identifiable, Codable {
    var id: String
    var name: String
    var imageName: String
    var price: Double

    init(id: String = UUID().uuidString, name: String, imageName: String, price: Double) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.price = price
    }
}

