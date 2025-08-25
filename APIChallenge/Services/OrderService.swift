//
//  OrderService.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 21/08/25.
//

import Foundation
import SwiftData

protocol OrderServiceProtocol {
    func addProductOrder(products: [CartProduct]) throws -> Void
    func fetchProductsOrder() throws -> [OrderedProduct]
}


class OrderService: OrderServiceProtocol {
    private let modelContext: ModelContext
    
    @MainActor
    init() {
        self.modelContext = LocalPersistence.shared.modelContext
    }

    func fetchProductsOrder() throws -> [OrderedProduct] {
        do {
            return try modelContext.fetch(FetchDescriptor<OrderedProduct>())
        } catch {
            throw NSError(domain: error.localizedDescription, code: 0)
        }
    }
    
    func addProductOrder(products: [CartProduct]) throws {
//        for product in products {
//            let orderProduct = OrderedProduct(productId: product.id, productTitle: product.title, productDetails: product.details, productPrice: product.price, productThumbnail: product.thumbnail, productCategory: product.category, productShippingInformation: product.shippingInformation, productQuantity: 1)
//            modelContext.insert(orderProduct)
//            try? modelContext.save()
//        }
    }
}
