//
//  MockCartService.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 26/08/25.
//


//
//  MockCartService.swift
//  APIChallengeTests
//
//  Created by Fernando Sulzbach on 26/08/25.
//

import Foundation
@testable import APIChallenge

class MockCartService: CartServiceProtocol {
    
    var shouldFail: Bool
    private var mockCart: [CartProduct]
    
    init(shouldFail: Bool = false, initialCart: [CartProduct] = []) {
        self.shouldFail = shouldFail
        self.mockCart = initialCart
    }
    
    func getCartProductIds() throws -> [CartProduct] {
        if shouldFail {
            throw NSError(domain: "MockCartService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Falha simulada ao buscar carrinho"])
        }
        return mockCart
    }
    
    func getProductCart(by id: Int) throws -> CartProduct? {
        if shouldFail {
            throw NSError(domain: "MockCartService", code: 2, userInfo: [NSLocalizedDescriptionKey: "Falha simulada ao buscar produto no carrinho"])
        }
        return mockCart.first(where: { $0.productId == id })
    }
    
    func addCartProductId(_ productId: Int) throws {
        if shouldFail {
            throw NSError(domain: "MockCartService", code: 3, userInfo: [NSLocalizedDescriptionKey: "Falha simulada ao adicionar produto no carrinho"])
        }
        
        if let index = mockCart.firstIndex(where: { $0.productId == productId }) {
            mockCart[index].quantity += 1
        } else {
            mockCart.append(CartProduct(productId: productId, quantity: 1))
        }
    }
    
    func updateCartProductId(_ cartProductID: CartProduct, quantity: Int) throws {
        if shouldFail {
            throw NSError(domain: "MockCartService", code: 4, userInfo: [NSLocalizedDescriptionKey: "Falha simulada ao atualizar quantidade"])
        }
        
        if let index = mockCart.firstIndex(where: { $0.productId == cartProductID.productId }) {
            mockCart[index].quantity = quantity
        }
    }
    
    func cleanCart() {
        if shouldFail {
            return // simula falha silenciosa
        }
        mockCart.removeAll()
    }
}
