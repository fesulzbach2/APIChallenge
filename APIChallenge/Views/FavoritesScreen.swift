//
//  EmptyState.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 14/08/25.
//


import SwiftUI
import SwiftData

struct Favorites: View {
    
    @State var viewModel: FavoritesViewModel
    
    var body: some View {
        
        NavigationStack {
            VStack{
                
                if(viewModel.products.isEmpty) {
                    EmptyState(icon: "heart.slash", headerText: "No favorites yet!", footerText: "Favorite an item and it will show up here.")
                    
                } else {
                    
                    List(viewModel.filteredFavorites) { product in
                        
                        ProductFavorite(product: product)
                            .padding(.top, 16)
                            .scrollContentBackground(.hidden)
                            .listStyle(.plain)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                viewModel.selectedProduct = product
                            }
                    }
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
            .searchable(text: $viewModel.searchText)
            
        }
        .toolbarBackground(.backgroundsPrimary, for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        
        .sheet(item: $viewModel.selectedProduct, onDismiss: {
            Task {
                await viewModel.loadProducts()
            }
        }, content: { product in
            if let index = viewModel.products.firstIndex(where: { $0.id == product.id }) {
                Details(viewModel: DetailsViewModel(productService: ProductService(), favoriteService: FavoritesService(), cartService: CartService()), product: $viewModel.products[index])
                    .presentationDragIndicator(.visible)
            }
        })
        
        .task {
            await viewModel.loadProducts()
        }
    }
}

#Preview {
    TabBar()
}
