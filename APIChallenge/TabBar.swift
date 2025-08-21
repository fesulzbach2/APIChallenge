//
//  TabBar.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 13/08/25.
//

import SwiftUI
import SwiftData

struct TabBar: View {
    var body: some View {
        TabView {
            
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    HomeView()
                }
            }
            
            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    CategoriesView()
                }
            }
            
            Tab("Cart", systemImage: "cart.fill") {
                NavigationStack {
                    CartView(viewModel: CartViewModel(cartService: CartService(), productService: ProductService()))
                }
            }
            
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                    Favorites(viewModel: FavoritesViewModel(
                        productService: ProductService(), favoriteService: FavoritesService()))
                }
            }
            
           Tab("Orders", systemImage: "bag.fill") {
                NavigationStack {
                    OrdersView()
                }
            }
        }
    }
}

#Preview {
    TabBar()
}
