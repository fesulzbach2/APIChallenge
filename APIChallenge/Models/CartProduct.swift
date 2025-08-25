//
//  StoredProduct 2.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 15/08/25.
//

import SwiftUI
import SwiftData

@Model
final class CartProduct: Identifiable {
    var productId: Int
    var quantity: Int

    init(productId: Int, quantity: Int) {
        self.productId = productId
        self.quantity = quantity
    }
}
