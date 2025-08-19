//
//  APIChallengeApp.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 13/08/25.
//

import SwiftUI

@main
struct APIChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(for: [Order.self, ProductToCart.self, StoredProductID.self, FavoritedProduct.self, OrderedProduct.self])
    }
}
