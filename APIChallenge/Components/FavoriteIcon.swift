//
//  FavoriteIcon.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 13/08/25.
//

import SwiftUI

struct FavoriteIcon: View {
    
    @Binding var product : Product
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
            product.isFavorite.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)  .fill(Color.fillsTertiary)
                    .frame(width: 38, height: 38)
                
                Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(.labelsPrimary)
                    .scaledToFit()
                //                    .frame(width: 38, height: 38)
            }
        }
        .buttonStyle(.plain)
        
    }
}

#Preview {
//    MediumCard(isHorizontal: true, category: .Beauty, text: "Product name with two or more lines goes here", price: 0.0)
}
