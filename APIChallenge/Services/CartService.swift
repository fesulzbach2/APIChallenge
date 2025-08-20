//
//  CartService.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 20/08/25.
//

import Foundation
import SwiftData

protocol CartServiceProtocol {
    func getCartProductIds() throws -> [CartProductID]
}


class CartService: CartServiceProtocol {
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    init() {
        self.modelContainer = try! ModelContainer(for: CartProductID.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    
    func getCartProductIds() throws -> [CartProductID] {
        do {
            return try modelContext.fetch(FetchDescriptor<CartProductID>())
        } catch {
            throw NSError(domain: error.localizedDescription, code: 0)
        }
    }
    
    func addCartProductId(_ cartProductID: CartProductID) {
        modelContext.insert(cartProductID)
    }
    
    
}
