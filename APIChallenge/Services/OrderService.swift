//
//  OrderService.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 21/08/25.
//

import Foundation
import SwiftData

protocol OrderServiceProtocol {
    func addProductOrder(products: [OrderedProduct]) throws -> Void
    func fetchProductsOrder() throws -> [OrderedProduct]
    func cleanOrders() throws -> Void
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
    
    func addProductOrder(products: [OrderedProduct]) throws {
        
        for product in products {
            modelContext.insert(product)
            try? modelContext.save()
        }
    }
    
    func cleanOrders() throws {
        do {
            let allOrders = try modelContext.fetch(FetchDescriptor<OrderedProduct>())
            for order in allOrders {
                modelContext.delete(order)
            }
            try modelContext.save()
        } catch {
            
        }
    }
}
