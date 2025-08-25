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
    func addCartProductId(_ productId: Int) throws -> Void
    
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
    
    func getProductCart(by id: Int) throws -> CartProductID?  {
        do {
            let descriptor = FetchDescriptor<CartProductID>(predicate: #Predicate {$0.productId == id} )
            return try modelContext.fetch(descriptor).first
        } catch {
            throw NSError(domain: error.localizedDescription, code: 0)
        }
    }
    
    func addCartProductId(_ productId: Int) throws -> Void {
        if let cartProduct = try getProductCart(by: productId) {
            try updateCartProductId(cartProduct, quantity: cartProduct.quantity + 1)
        } else {
            let newCartProduct = CartProductID(productId: productId, quantity: 1)
            modelContext.insert(newCartProduct)
        }
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
