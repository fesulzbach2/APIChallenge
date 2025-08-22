//
//  APIChallengeApp.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 13/08/25.
//

import SwiftUI
import SwiftData

@main
struct APIChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(
            for: [FavoritedProduct.self, OrderedProduct.self])
    }
}
