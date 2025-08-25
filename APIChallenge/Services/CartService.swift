//
//  CartService.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 20/08/25.
//

import Foundation
import SwiftData

protocol CartServiceProtocol {
    func getCartProductIds() throws -> [CartProduct]
    func addCartProductId(_ productId: Int) throws -> Void
    
    func updateCartProductId(_ cartProductID: CartProduct, quantity: Int) throws
    func cleanCart()
//    func removeCartProductId(_ cartProductID: CartProductID) throws
}


class CartService: CartServiceProtocol {
    private let modelContext: ModelContext
    
    @MainActor
    init() {
        self.modelContext = LocalPersistence.shared.modelContext
    }
    
    
    func getCartProductIds() throws -> [CartProduct] {
        do {
            return try modelContext.fetch(FetchDescriptor<CartProduct>())
        } catch {
            throw NSError(domain: error.localizedDescription, code: 0)
        }
    }
    
    func getProductCart(by id: Int) throws -> CartProduct?  {
        do {
            let descriptor = FetchDescriptor<CartProduct>(predicate: #Predicate {$0.productId == id} )
            return try modelContext.fetch(descriptor).first
        } catch {
            throw NSError(domain: error.localizedDescription, code: 0)
        }
    }
    
    func addCartProductId(_ productId: Int) throws -> Void {
        if let cartProduct = try getProductCart(by: productId) {
            try updateCartProductId(cartProduct, quantity: cartProduct.quantity + 1)
        } else {
            let newCartProduct = CartProduct(productId: productId, quantity: 1)
            modelContext.insert(newCartProduct)
        }
    }
    
    func updateCartProductId(_ cartProductID: CartProduct, quantity: Int) throws {
        cartProductID.quantity = quantity
         try modelContext.save()
    }
    
    func cleanCart() {
        do {
            let allOrders = try modelContext.fetch(FetchDescriptor<CartProduct>())
            for order in allOrders {
                modelContext.delete(order)
            }
            try modelContext.save()
        } catch {
            
        }
    }
}
