//
//  CategoryScreen.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 15/08/25.
//

import SwiftUI

struct CategoryScreen: View {

    var category: Category
    
    @State var viewModel: CategoryViewModel
    
    private func binding(for product: Product) -> Binding<Product> {
        if let i = viewModel.products.firstIndex(where: { $0.id == product.id }) {
            return Binding(
                get: { viewModel.products[i] },
                set: { viewModel.products[i] = $0 }
            )
        } else {
            return .constant(product)
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
                        ForEach(viewModel.filteredProducts) { product in
                            HStack{
                                MediumCard(
                                    isHorizontal: false,
                                    product: binding(for: product),
                                    action: {
                                        viewModel.toggleFavorite(product: product)
                                    }
                                )
                                
                            }
                            
                        }
                        
                        
                    }
                    .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
                }
            }
            Divider()
            
        }
        .navigationTitle(category.rawValue.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 16)
        .task {
            await viewModel.loadProducts(category: category)
        }
    }
}

#Preview {
    TabBar()
}
