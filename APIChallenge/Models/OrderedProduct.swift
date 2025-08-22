//
//  OrderProduct.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 21/08/25.
//

import SwiftUI
import SwiftData

@Model
final class OrderedProduct: Identifiable {
    var productId: Int
    var product: Product
    var quantity: Int

    init(productId: Int, product: Product, quantity: Int) {
        self.productId = productId
        self.product = product
        self.quantity = quantity
    }
}
