//
//  CategoryIcon.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 14/08/25.
//

import SwiftUI

struct CategoryIcon: View {
    var category : Category
    var action: () -> Void
    
    var body: some View {
        let spec = Fonts.specs(for: .subheadlineRegular)
        let twoLineMinHeight = spec.lineHeight * 2
        
        NavigationLink {
            CategoryScreen(category: category, viewModel: CategoryViewModel(productService: ProductService(), favoriteService: FavoritesService()))

        } label: {
            VStack(alignment: .center, spacing: 0) {
                category.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 84, height: 84)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(category.rawValue)
                    .lineLimit(2)
                    .typography(.subheadlineRegular)
                    .frame(minHeight: twoLineMinHeight, alignment: .leading)
            }
            .frame(width: 84)
        }
        .buttonStyle(.plain)
        
    }
}

#Preview {
    CategoryIcon(category: .Beauty, action: {print("öi")})
}
