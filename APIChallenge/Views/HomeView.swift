//
//  HomeScreen.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 14/08/25.
//

import SwiftUI

struct HomeView: View {
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
                        
                        if let dealOfDay = viewModel.products.first {
                            MediumCard(isHorizontal: true,
                                       product: .constant(dealOfDay),
                                       action: {
                                            viewModel.toggleFavorite(product: dealOfDay)
                                        }
                            )
                        }
                        
                        Text("Top picks")
                            .typography(.title1Emphasized)
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach($viewModel.products, id: \.id) { $product in
                                HStack{
                                    MediumCard(
                                        isHorizontal: false,
                                        product: $product,
                                        action: {
                                            viewModel.toggleFavorite(product: product)
                                        }
                                    )
                                }

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
