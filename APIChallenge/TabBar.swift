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
            
            Tab("Orders", systemImage: "bag.fill") {
                NavigationStack {
                    Orders(viewModel: ProductViewModel(service: ProductService()))
                }
            }
            
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                    Favorites()
                }
            }
            
            
            
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                }
            }
            
            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                }
            }
            
            Tab("Cart", systemImage: "cart.fill") {
                NavigationStack {
                }
            }
            
            
            
            
        }
    }
}

#Preview {
    TabBar()
}
