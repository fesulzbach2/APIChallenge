//
//  FavoritesViewModel.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 20/08/25.
//


import Foundation
import SwiftData

@Observable
class DetailsViewModel: ObservableObject {
    
    var product: Product?
    
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let productService: ProductServiceProtocol
    private let favoriteService: FavoritesServiceProtocol
    
    init(productService: ProductServiceProtocol, favoriteService: FavoritesServiceProtocol) {
        self.productService = productService
        self.favoriteService = favoriteService
    }
    
    func toggleFavorite(product: Product)  {
        if product.isFavorite {
            favoriteService.removeFavoritedProduct(id: product.id)
        } else {
            favoriteService.addFavoritedProduct(id: product.id)
            
        }
    }
        
}
