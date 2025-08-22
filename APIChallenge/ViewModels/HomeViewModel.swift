//
//  FavoritesViewModel.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 20/08/25.
//


import Foundation
import SwiftData

@Observable
class HomeViewModel: ObservableObject {
    
    var products: [Product] = []
    var favoritedProducts: [FavoritedProduct] = []
    
    var isLoading: Bool = true
    var errorMessage: String? = nil
    
    
    private let productService: ProductServiceProtocol
    private let favoriteService: FavoritesServiceProtocol
    
    init(productService: ProductServiceProtocol, favoriteService: FavoritesServiceProtocol) {
        self.productService = productService
        self.favoriteService = favoriteService
    }
    
    func loadProducts() async {
        isLoading = true
        
        do {
            loadFavoritedProducts()
            products = try await productService.fetchProducts()
            updateFavorites()
        } catch {
            errorMessage = "Error to fetch products: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func loadFavoritedProducts() {
        do {
            favoritedProducts = try favoriteService.fetchFavoritedProductsIDs()
        } catch {
            errorMessage = "Error to fetch favorited products: \(error.localizedDescription)"
        }
    }
    
    func updateFavorites() {
        let favoritedIDs = Set(favoritedProducts.map { $0.id })
        
        for id in favoritedIDs {
            if let index = products.firstIndex(where: { $0.id == id }) {
                products[index].isFavorite = true
            }
        }
    }
    
    func toggleFavorite(product: Product) {
        if product.isFavorite {
            favoriteService.removeFavoritedProduct(id: product.id)
        } else {
            favoriteService.addFavoritedProduct(id: product.id)
        }
    }
    
//    var filteredFavorites: [Product] {
//        
//        if searchText.isEmpty {
//            return products.filter { $0.isFavorite }
//        } else {
//            return products.filter { $0.isFavorite && $0.title.lowercased().contains(searchText.lowercased()) }
//        }
//    }
}
