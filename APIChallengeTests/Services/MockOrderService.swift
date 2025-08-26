//
//  MockOrderService.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 26/08/25.
//


//
//  MockOrderService.swift
//  APIChallengeTests
//
//  Created by Fernando Sulzbach on 26/08/25.
//

import Foundation
@testable import APIChallenge

class MockOrderService: OrderServiceProtocol {
    
    var shouldFail: Bool
    private var mockOrders: [OrderedProduct]
    
    init(shouldFail: Bool = false, initialOrders: [OrderedProduct] = []) {
        self.shouldFail = shouldFail
        self.mockOrders = initialOrders
    }
    
    func fetchProductsOrder() throws -> [OrderedProduct] {
        if shouldFail {
            throw NSError(domain: "MockOrderService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Falha simulada ao buscar pedidos"])
        }
        return mockOrders
    }
    
    func addProductOrder(products: [OrderedProduct]) throws {
        if shouldFail {
            throw NSError(domain: "MockOrderService", code: 2, userInfo: [NSLocalizedDescriptionKey: "Falha simulada ao adicionar pedido"])
        }
        mockOrders.append(contentsOf: products)
    }
    
    func cleanOrders() throws {
        if shouldFail {
            throw NSError(domain: "MockOrderService", code: 3, userInfo: [NSLocalizedDescriptionKey: "Falha simulada ao limpar pedidos"])
        }
        mockOrders.removeAll()
    }
}
