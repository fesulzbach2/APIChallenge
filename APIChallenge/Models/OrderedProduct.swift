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

    init(productId: Int, product: Product) {
        self.productId = productId
        self.product = product
    }
}
