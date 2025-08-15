//
//  TabBar.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 13/08/25.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    HomeScreen()
                }
            }
            
            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    CategoriesScreen()
                }
            }
            
            Tab("Cart", systemImage: "cart.fill") {
                NavigationStack {
                }
            }
            
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                }
            }
            
            Tab("Orders", systemImage: "bag.fill") {
                NavigationStack {
                }
            }
        }
    }
}

#Preview {
    TabBar()
}
