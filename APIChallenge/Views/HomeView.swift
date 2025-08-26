//
//  HomeScreen.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 14/08/25.
//

import SwiftUI

struct HomeScreen: View {
    //  @State var isLoading: Bool = true
    // @State var products: [Product] = []
    //  private let service = ProductService()
    
    @State private var viewModel = HomeViewModel(productService: ProductService(), favoriteService: FavoritesService())
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.isLoading {
                
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            } else {
                ScrollView{
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Deals of the day")
                            .typography(.title1Emphasized)
                        
                        if let dealOfDay = viewModel.products.firstIndex(where: {_ in true}) {
                            MediumCard(isHorizontal: true,
                                       product: $viewModel.products[dealOfDay],
                                       action: {
                                viewModel.toggleFavorite(product: viewModel.products[dealOfDay])
                            }
                            )
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("Card with deals of the day. \(viewModel.products[dealOfDay].title), US$ \(String(format: "%.2f", viewModel.products[dealOfDay].price)) dolars")
                        }
                        
                        Text("Top picks")
                            .typography(.title1Emphasized)
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach($viewModel.products, id: \.id) { $product in
                                let title = product.title
                                let price = String(format: "%.2f", product.price)
                                
                                MediumCard(
                                    isHorizontal: false,
                                    product: $product,
                                    action: {
                                        viewModel.toggleFavorite(product: product)
                                    }
                                )
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel("Card with top pick. \(title), US$ \(price) dolars")
                            }
                        }
                    }
                }
            }
            
            
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal, 16)
        .task {
            await viewModel.loadProducts()
        }
    }
}

#Preview {
    TabBar()
}
