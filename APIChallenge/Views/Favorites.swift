//
//  EmptyState.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 14/08/25.
//


import SwiftUI

struct Favorites: View {
    
    var icon: String = "cart.badge.questionmark"
    var headerText: String = "Your cart is empty!"
    var footerText: String = "Add an item to your cart."
    
    @State var empty: Bool = false
    
    @State var productList: [ProductFavorite] = [
        ProductFavorite(category: .Beauty, name: "Product name", price: 120.00),
        ProductFavorite(category: .Beauty, name: "Product name with two or more lines goes here", price: 40.00),
        ProductFavorite(category: .Beauty, name: "Product name with two or more lines goes here", price: 100.00),
        ProductFavorite(category: .Beauty, name: "Product name", price: 100.00),
        ProductFavorite(category: .Beauty, name: "Product name with two or more lines goes here", price: 99.90),


    ]
    
    var body: some View {
        
        NavigationStack {
            VStack{
                
                if(empty) {
                    EmptyState(icon: "heart.slash", headerText: "No favorites yet!", footerText: "Favorite an item and it will show up here.")
                    
                } else {
                    List(productList, id: \.name) { product in
                        ProductFavorite(category: product.category, name: product.name, price: product.price)
                           .padding(.top, 16)
                            .scrollContentBackground(.hidden)
                            .listStyle(.plain)
                            .listRowInsets(EdgeInsets())
                    }
                  //  .padding(.vertical)
                    .listRowSeparator(.hidden)
                    .listStyle(.plain)
                    .listRowInsets(EdgeInsets())
                }
                
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .navigationTitle("Favorites")
            .searchable(text: .constant(""))
            
        }
        .toolbarBackground(.backgroundsPrimary, for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
         
    }
        
}

#Preview {
    TabBar()
}
