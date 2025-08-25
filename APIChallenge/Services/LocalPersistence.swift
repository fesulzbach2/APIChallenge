//
//  LocalPersistence.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 22/08/25.
//

import SwiftData

class LocalPersistence {
    let modelContainer: ModelContainer
    let modelContext: ModelContext
    
    @MainActor
    static let shared = LocalPersistence()
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: FavoritedProduct.self, CartProduct.self, OrderedProduct.self)
        self.modelContext = modelContainer.mainContext
    }
}
