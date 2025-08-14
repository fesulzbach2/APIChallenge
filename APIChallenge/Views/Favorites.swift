//
//  EmptyState.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 14/08/25.
//


import SwiftUI

struct Favorites: View {
    
    let viewModel: ProductViewModel
    
    var icon: String = "cart.badge.questionmark"
    var headerText: String = "Your cart is empty!"
    var footerText: String = "Add an item to your cart."
    
    @State var empty: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack{
                
                if(empty) {
                    EmptyState(icon: "heart.slash", headerText: "No favorites yet!", footerText: "Favorite an item and it will show up here.")
                    
                } else {
                    List(viewModel.products) { product in
                        ProductFavorite(product: product)
                           .padding(.top, 16)
                            .scrollContentBackground(.hidden)
                            .listStyle(.plain)
                            .listRowInsets(EdgeInsets())
                           // .listRowSeparator(.hidden)
                    }
                  //  .padding(.vertical)
                    .listRowSeparator(.hidden)
                    .listStyle(.plain)
                    .listRowInsets(EdgeInsets())
                    .refreshable {
                        await viewModel.loadProducts()
                    }
                }
                
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .navigationTitle("Favorites")
            .searchable(text: .constant(""))
            
        }
        .toolbarBackground(.backgroundsPrimary, for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        
        .task {
            await viewModel.loadProducts()
        }
         
    }
        
}
