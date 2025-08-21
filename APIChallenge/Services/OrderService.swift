//
//  OrderService.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 21/08/25.
//

import Foundation
import SwiftData

protocol OrderServiceProtocol {
    func addProductOrder(product: OrderedProductId) throws -> Void
    func fetchProductsOrder() throws -> [OrderedProductId]
}


class OrderService: OrderServiceProtocol {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    init() {
        self.modelContainer = try! ModelContainer(for: OrderedProductId.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    func addProductOrder(product: OrderedProductId) throws -> Void {
        modelContext.insert(product)
    }
    
    func fetchProductsOrder() throws -> [OrderedProductId] {
        do {
            return try modelContext.fetch(FetchDescriptor<OrderedProductId>())
        } catch {
            throw NSError(domain: error.localizedDescription, code: 0)
        }
    }
}
