//
//  Order.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 19/08/25.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class Order {
    @Attribute(.unique) var id: UUID
    var products: [ProductToCart] = []

    init(id: UUID = UUID(), products: [ProductToCart] = []) {
        self.id = id
        self.products = products
    }
    
}
