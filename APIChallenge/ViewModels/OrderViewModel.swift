//
//  OrderViewModel.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 21/08/25.
//

import Foundation

@Observable
class OrderViewModel {
    
    var orderedProducts: [OrderedProduct] = []
    var errorMessage: String?
    
    private let orderService: any OrderServiceProtocol
    private let productService: any ProductServiceProtocol
    
    
    init(orderService: any OrderServiceProtocol, productService: ProductServiceProtocol) {
        self.orderService = orderService
        self.productService = productService
        
    }
    
    func getCartProducts() async {
        
        do {
            
            let orderProducts: [OrderedProductId] = try orderService.fetchProductsOrder()
            let ids = orderProducts.map { $0.productId }
            
            let products: [Product] = try await productService.fetchProducts(for: ids)
            
            var merged: [OrderedProduct] = []
            
            for id in ids {
                guard let product = products.first(where: { $0.id == id}) else { continue }
                
                let ordered = OrderedProduct(productId: id, product: product)
                merged.append(ordered)
                merged.append(ordered)
            }
            
            self.orderedProducts = merged
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
    }
}
