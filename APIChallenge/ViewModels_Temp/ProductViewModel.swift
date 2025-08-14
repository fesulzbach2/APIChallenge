//
//  CharacterViewModel.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import Foundation

@Observable
class ProductViewModel: ProductViewModelProtocol {
    var product: Product?
    var products: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    func loadProducts() async {
        isLoading = true
        
        do {
            product = try await service.fetchProduct(number: 2)
            products = try await service.fetchProducts()
            print(products)
        } catch {
            errorMessage = "Error to fetch products: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
