//
//  OrderService.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 21/08/25.
//

import Foundation
import SwiftData

protocol OrderServiceProtocol {
//    func addProductOrder(product: OrderedProduct) throws -> Void
    func addProductOrder(products: [CartProduct]) throws -> Void
    func fetchProductsOrder() throws -> [OrderedProduct]
}


class OrderService: OrderServiceProtocol {
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    init() {
        self.modelContainer = try! ModelContainer(for: OrderedProduct.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
//    func addProductOrder(product: OrderedProduct) throws -> Void {
//        modelContext.insert(product)
//    }
    
    func fetchProductsOrder() throws -> [OrderedProduct] {
        do {
            return try modelContext.fetch(FetchDescriptor<OrderedProduct>())
        } catch {
            throw NSError(domain: error.localizedDescription, code: 0)
        }
    }
    
    func addProductOrder(products: [CartProduct]) throws {
        for cartItem in products {
            let orderProduct = OrderedProduct(productId: cartItem.id, product: cartItem.product, quantity: cartItem.quantity)
            modelContext.insert(orderProduct)
        }
    }
}
