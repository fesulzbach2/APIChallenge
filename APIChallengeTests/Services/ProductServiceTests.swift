//
//  MockProductService.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 25/08/25.
//


import Foundation
@testable import APIChallenge // Importa seu app para ter acesso ao protocolo e modelos

class ProductServiceTests: ProductServiceProtocol {
        
    var mockProducts: [Product]
    
    var shouldFail: Bool
    
    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
        if shouldFail {
            self.mockProducts = []
            
        } else {
            self.mockProducts = [Product (id: 1, title: "Product 1", details: "This Product is a product", price: 10.50, thumbnail: "thumbnail mock", category: "Beauty", shippingInformation: "Ships in 2-3 days"),
                                  Product (id: 2, title: "Product 2", details: "Product Details", price: 10.0, thumbnail: "Product thumbnail", category: "Beauty", shippingInformation: "Ships in 2-3 days")]
        }
    }

    func fetchProduct(number: Int) async throws -> Product {
        if shouldFail {
            throw NSError(domain: "MockProductService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Falha simulada na busca de produtos"])
        }
        
        let foundProduct =  mockProducts.first(where: {$0.id == number})
        print("Mock: Retornando produtos encontrado")
        return foundProduct ?? mockProducts[0]
    }
    
    func fetchProducts(for ids: [Int]) async throws -> [Product] {
        if shouldFail {
            throw NSError(domain: "MockProductService", code: 1, userInfo: [NSLocalizedDescriptionKey: "Falha simulada na busca de produtos"])
        }
        
        var foundProducts: [Product] = []
        
        for id in ids {
            foundProducts.append(try await fetchProduct(number: id))
        }
    
        return foundProducts
    }

    func fetchProducts() async throws -> [Product] {
        if shouldFail {
            throw NSError(domain: "MockProductService", code: 2, userInfo: [NSLocalizedDescriptionKey: "Falha simulada na busca de produto único"])
        }

        return mockProducts
    }
}
