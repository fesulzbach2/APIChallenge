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
    private let cartService: CartServiceProtocol
    
    init(productService: ProductServiceProtocol, favoriteService: FavoritesServiceProtocol, cartService: CartServiceProtocol) {
        self.productService = productService
        self.favoriteService = favoriteService
        self.cartService = cartService
    }
    
    func toggleFavorite(product: Product)  {
        if product.isFavorite {
            favoriteService.removeFavoritedProduct(id: product.id)
        } else {
            favoriteService.addFavoritedProduct(id: product.id)
            
        }
    }
    
    func addToCart(_ id: Int) {
        do {
            try cartService.addCartProductId(id)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
        
}
