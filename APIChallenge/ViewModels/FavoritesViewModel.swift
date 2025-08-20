//
//  FavoritesViewModel.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 20/08/25.
//


import Foundation
import SwiftData

@Observable
class FavoritesViewModel: ObservableObject {
    
    var products: [Product] = []
    var searchText: String = ""
    var selectedProduct: Product?
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let productService: ProductServiceProtocol
    private let favoriteService: FavoritesServiceProtocol
    
    var favoritedProductsIDs: [FavoritedProduct] = []
    
    
    init(productService: ProductServiceProtocol, favoriteService: FavoritesServiceProtocol) {
        self.productService = productService
        self.favoriteService = favoriteService
    }
    
    func loadProducts() async {
        isLoading = true
        
        do {
            let favoritedProductsIDs: [FavoritedProduct] = try favoriteService.fetchFavoritedProductsIDs()
            let ids = favoritedProductsIDs.map { $0.id }
            
            products = try await productService.fetchProducts(for: ids)
            
        } catch {
            errorMessage = "Error to fetch products: \(error.localizedDescription)"
            
        }
        
        isLoading = false
        
    }
        
    var filteredFavorites: [Product] {
        
        if searchText.isEmpty {
            return products.filter { $0.isFavorite }
        } else {
            return products.filter { $0.isFavorite && $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
}
