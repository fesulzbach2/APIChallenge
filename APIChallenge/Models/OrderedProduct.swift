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
    var productTitle: String
    var productDetails: String
    var productPrice: Double
    var productThumbnail: String
    var productCategory: String
    var productShippingInformation: String
    var productQuantity: Int
    
    init(productId: Int, productTitle: String, productDetails: String, productPrice: Double, productThumbnail: String, productCategory: String, productShippingInformation: String, productQuantity: Int) {
        self.productId = productId
        self.productTitle = productTitle
        self.productDetails = productDetails
        self.productPrice = productPrice
        self.productThumbnail = productThumbnail
        self.productCategory = productCategory
        self.productShippingInformation = productShippingInformation
        self.productQuantity = productQuantity
    }
}
