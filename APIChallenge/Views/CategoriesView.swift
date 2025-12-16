//
//  CategoriesScreen.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 14/08/25.
//

import SwiftUI
#if os(iOS)
import UIKit
#endif

struct CategoriesScreen: View {
    
    
    @State var viewModel: CategoriesViewModel
    
    private var iconPrefixCount: Int {
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            let isLandscape = UIScreen.main.bounds.width > UIScreen.main.bounds.height
            return isLandscape ? 10 : 8
        } else {
            return 4
        }
    }
    
    private var iconPrefixDistance: Int {
        UIDevice.current.userInterfaceIdiom == .pad ? 16 : 8
    }
    
    private var screenPadding: Int {
        UIDevice.current.userInterfaceIdiom == .pad ? 32 : 16
    }
    
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
                HStack(spacing: CGFloat(iconPrefixDistance)) {
                    ForEach(Category.allCases.prefix(iconPrefixCount), id: \.id) { category in
                        HStack{
                            CategoryIcon(category: category, action: {print("botao funcionando")})
                                .accessibilityLabel("\(category) double click to enter")
                        }
                    }
                }
                
                ForEach(viewModel.filteredCategories, id: \.self) { category in
                    categoryList(category: category)
                        .padding(.vertical, 19)
                        .accessibilityLabel("\(category) double click to enter")
                    Divider()
                }
            }
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.large)
            .padding(.horizontal, CGFloat(screenPadding))
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .padding(.top, CGFloat(iconPrefixDistance))
            
        }
    }
}

#Preview {
    TabBar()
}
