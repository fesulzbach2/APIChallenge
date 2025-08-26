//
//  CharacterViewModel.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import Foundation

@Observable
class ProductViewModel: ProductViewModelProtocol, ObservableObject {
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
            products = try await service.fetchProducts()
        } catch {
            errorMessage = "Error to fetch products: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func loadProduct(id: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            product = try await service.fetchProduct(number: id)
        } catch {
            errorMessage = "Error to fetch product: \(error.localizedDescription)"
        }
    }

}
