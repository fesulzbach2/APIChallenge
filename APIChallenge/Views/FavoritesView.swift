//
//  EmptyState.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 14/08/25.
//


import SwiftUI
import SwiftData

struct Favorites: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var favoritedProducts: [StoredProductID]
    
    @State var viewModel: ProductViewModel
    
    var filteredViewModel: [Product] {
        
        let favoriteIDs = Set(favoritedProducts.map { $0.id })
        
        for index in viewModel.products.indices {
            if favoriteIDs.contains(viewModel.products[index].id) {
                viewModel.products[index].isFavorite = true
            }
        }
        
        return viewModel.products.filter { $0.isFavorite}
    }

    var icon: String = "cart.badge.questionmark"
    var headerText: String = "Your cart is empty!"
    var footerText: String = "Add an item to your cart."
    
    @State var empty: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack{
                
                if(filteredViewModel.isEmpty) {
                    EmptyState(icon: "heart.slash", headerText: "No favorites yet!", footerText: "Favorite an item and it will show up here.")
                    
                } else {
                    
                    List(filteredViewModel) { product in
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

#Preview {
    TabBar()
}
