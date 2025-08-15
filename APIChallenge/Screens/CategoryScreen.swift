//
//  CategoryScreen.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 15/08/25.
//

import SwiftUI

struct CategoryScreen: View {
    var category: Category
    @State private var searchedProduct: String = ""
    @State private var viewModel = ProductViewModel(service: ProductService())
    private let service = ProductService()
    
    var productsByCategory: [Product] {
        return viewModel.products.filter{ $0.category.lowercased() == category.rawValue.lowercased() }
    }
    
    var filteredProducts: [Product] {
        searchedProduct.isEmpty
        ? productsByCategory
        : productsByCategory.filter{ product in
            product.title.lowercased().contains(searchedProduct.lowercased())
        }
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        VStack{
            NavigationStack {
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredProducts, id: \.id) { product in
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
                    .searchable(text: $searchedProduct, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
                }
            }
            Divider()

        }
        .navigationTitle(category.rawValue.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 16)
        .task {
            await viewModel.loadProducts()
        }
    }
}

#Preview {
    TabBar()
}
