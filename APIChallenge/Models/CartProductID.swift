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
final class CartProductID {
    var productId: Int
    var quantity: Int

    init(productId: Int, quantity: Int) {
        self.productId = productId
        self.quantity = quantity
    }
    
}
