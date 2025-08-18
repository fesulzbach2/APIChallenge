//
//  CategoriesScreen.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 14/08/25.
//

import SwiftUI

struct CategoriesScreen: View {
    @State private var searchedCategories: String = ""
    
    var filteredCategories: [Category] {
        searchedCategories.isEmpty
            ? Category.allCases
            : Category.allCases.filter {
            $0.rawValue.localizedCaseInsensitiveContains(searchedCategories)
        }
    }
    
    func categoryList (category: Category) -> some View {
        NavigationLink {
            CategoryScreen(category: category)
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
                            }
                        }
                    }
                }
                .padding(.top, 16)
                
                ForEach(filteredCategories, id: \.self) { category in
                    categoryList(category: category)
                        .padding(.vertical, 19)
                    Divider()
                }
            }
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.large)
            .padding(.horizontal, 16)
            .searchable(text: $searchedCategories, prompt: "Seach")
            
        }
    }
}

#Preview {
    TabBar()
}
