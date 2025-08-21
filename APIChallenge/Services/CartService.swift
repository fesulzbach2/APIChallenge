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
    func addCartProductId(_ cartProductID: CartProductID) throws -> Void
    
    func updateCartProductId(_ cartProductID: CartProductID, quantity: Int) throws
//    func removeCartProductId(_ cartProductID: CartProductID) throws
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
    
    func addCartProductId(_ cartProductID: CartProductID) throws -> Void {
        modelContext.insert(cartProductID)
    }
    
    func updateCartProductId(_ cartProductID: CartProductID, quantity: Int) throws {
        cartProductID.quantity = quantity
         try modelContext.save()
    }
    
//    func removeCartProductId(_ cartProductID: CartProductID) throws {
//        cartProductID.delete = quantity
//         try modelContext.save()
//    }
}
