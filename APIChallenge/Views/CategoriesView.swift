//
//  CategoriesScreen.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 14/08/25.
//

import SwiftUI

struct CategoriesScreen: View {

    
    @State var viewModel: CategoriesViewModel
    
    func categoryList (category: Category) -> some View {
        NavigationLink {
            CategoryScreen(category: category, viewModel: CategoryViewModel(productService: ProductService(), favoriteService: FavoritesService()))
        } label: {
            HStack{
                Text(category.rawValue)
                    .typography(.bodyRegular)
                    .foregroundStyle(.labelsPrimary)
                Spacer()
                Image(systemName: "chevron.forward")
                    .resizable()
                    .frame(width: 11, height: 22)
                    .frame(alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.labelsTertiary)
            }
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 16) {
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        ForEach(Category.allCases, id: \.id) { category in
                            HStack{
                                CategoryIcon(category: category, action: {print("botao funcionando")})
                                    .accessibilityLabel("\(category) double click to enter")
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .contentMargins(.leading, 16)
                .padding(.top, 16)
                
                ForEach(viewModel.filteredCategories, id: \.self) { category in
                    categoryList(category: category)
                        .padding(.vertical, 19)
                        .accessibilityLabel("\(category) double click to enter")
                    Divider()
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.large)
            .padding(.horizontal, 0)
            .searchable(text: $viewModel.searchText, prompt: "Search")
            
        }
    }
}

#Preview {
    TabBar()
}
