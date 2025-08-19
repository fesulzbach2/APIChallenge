//
//  ProductCart.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 19/08/25.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class ProductToCart {
    @Attribute(.unique) var id: UUID
    var productId: Int
    var quantity: Int

    init(id: UUID = UUID(), productId: Int, quantity: Int) {
        self.id = id
        self.productId = productId
        self.quantity = quantity
    }
    
}
