//
//  HomeScreen.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 14/08/25.
//

import SwiftUI

struct HomeScreen: View {
    @State var isLoading: Bool = true
    @State var products: [Product] = []
    private let service = ProductService()
    @State private var viewModel = ProductViewModel(service: ProductService())
    
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
                        
                        if let dealOfDay = viewModel.product {
                            MediumCard(isHorizontal: true, category: Category(rawValue: dealOfDay.category) ?? .Beauty, text: dealOfDay.title, price: dealOfDay.price, image: dealOfDay.thumbnail)
                        }
                        
                        Text("Top picks")
                            .typography(.title1Emphasized)
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.products, id: \.id) { product in
                                HStack{
                                    MediumCard(
                                        isHorizontal: false,
                                        category: Category(rawValue: product.category) ?? .Beauty,
                                        text: product.title,
                                        price: product.price,
                                        image: product.thumbnail,
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
            let single = try? await service.fetchProduct(number: 2)
            viewModel.product = single
        }
    }
}

#Preview {
    TabBar()
}
