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
        
        Button {
            action()
        } label: {
            VStack(alignment: .center, spacing: 8) {
                category.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(category.rawValue)
                    .lineLimit(2)
                    .typography(.subheadlineRegular)
                    .frame(minHeight: twoLineMinHeight, alignment: .leading)
            }
            .frame(width: 100)
        }
        .buttonStyle(.plain)
        
    }
}

#Preview {
    TabBar()
}
