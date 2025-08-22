//
//  FavoritesServiceTests.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 22/08/25.
//

import Foundation
@testable import APIChallenge

@Observable
class FavoritesServiceTests: FavoritesServiceProtocol {
        
    var favorites: [FavoritedProduct] = []
    
    init(favorites: [FavoritedProduct] = [FavoritedProduct(id: 10)]) {
        
    }
    
    func fetchFavoritedProductsIDs() throws -> [FavoritedProduct] {
        do {
            return try modelContext.fetch(FetchDescriptor<FavoritedProduct>())
        } catch {
            throw NSError(domain: "FavoritesService", code: 1, userInfo: nil)
        }
    }
    
    func addFavoritedProduct(id: Int) {
        do {
            let product = FavoritedProduct(id: id)
            modelContext.insert(product)
            try modelContext.save()
            print("added \(product.id)")
            
        } catch {
            print("Failed to add favorite: \(error)")
        }
    }
    
    func removeFavoritedProduct(id: Int) {
        let fetchDescriptor = FetchDescriptor<FavoritedProduct>(
            predicate: #Predicate { $0.id == id }
        )
        
        do {
            if let productToDelete = try modelContext.fetch(fetchDescriptor).first {
                modelContext.delete(productToDelete)
                try modelContext.save()
                print("Removed \(productToDelete.id)")
            }
        } catch {
            print("Failed to remove favorite: \(error)")
        }
    }

    
    
}


