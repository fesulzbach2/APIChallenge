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
    
    @Query var favoritedProducts: [FavoritedProduct]
    
    @State var viewModel: ProductViewModel
    
    @State var selectedProduct: Product? = nil
    
    @State private var searchText = ""
    
    func updateFavorites() {
        let favoriteIDs = Set(favoritedProducts.map { $0.id })
        for index in viewModel.products.indices {
            viewModel.products[index].isFavorite = favoriteIDs.contains(viewModel.products[index].id)
        }
    }
    
    var filteredViewModel: [Product] {
        
        if searchText.isEmpty {
            
            return viewModel.products.filter { $0.isFavorite}
        } else {
            
            return viewModel.products.filter { $0.isFavorite && $0.title.lowercased().contains(searchText.lowercased()) }
        }
        
        
      //  return viewModel.products.filter { $0.isFavorite}
    }
    
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
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                selectedProduct = product
                            }
                    }
                   // .allowsHitTesting(false)
                  //  .padding(.vertical)
                    .listRowSeparator(.hidden)
                    .listStyle(.plain)
                    .listRowInsets(EdgeInsets())
                    .refreshable {
                        await viewModel.loadProducts()
                        updateFavorites()
                    }
                }
                
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .navigationTitle("Favorites")
            .searchable(text: $searchText)
            
        }
        .toolbarBackground(.backgroundsPrimary, for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        
        .sheet(item: $selectedProduct) { product in
            if let index = viewModel.products.firstIndex(where: { $0.id == product.id }) {
                Details(product: $viewModel.products[index])
                    .presentationDragIndicator(.visible)
            }
        }
        
        .task {
                await viewModel.loadProducts()
                updateFavorites()
            }
        .onChange(of: favoritedProducts) { _ in
            updateFavorites()
        }

         
    }
        
}

#Preview {
    TabBar()
}
