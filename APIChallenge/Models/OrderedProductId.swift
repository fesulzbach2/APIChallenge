//
//  ProductResponse.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 18/08/25.
//


import SwiftUI
import SwiftData

@Model
final class OrderedProductId {
    var productId: Int
    
    init(productId: Int) {
        self.productId = productId
    }
}
