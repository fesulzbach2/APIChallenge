//
//  ProductResponse.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 18/08/25.
//


import SwiftUI
import SwiftData

@Model
final class OrderedProduct {
    var id: Int
    var title: String
    var productDescription: String
    var price: Double
    var thumbnail: String
    var category: String
    var shippingInformation: String
    
    init(id: Int, title: String, productDescription: String, price: Double, thumbnail: String, category: String, shippingInformation: String) {
        self.id = id
        self.title = title
        self.productDescription = productDescription
        self.price = price
        self.thumbnail = thumbnail
        self.category = category
        self.shippingInformation = shippingInformation
    }
}
