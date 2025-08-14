//
//  ContentView.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 13/08/25.
//

import SwiftUI

struct ProductDetailsImage: View {
    
   var product: Product
    
    var category: Categories = .Beauty
    var deliveryDate: String = "DELIVERY BY MONTH, 00"
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                            image.resizable()
                        } placeholder: {
                            category.image
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .frame(alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            Button {
                                
                            } label: {
                                Image(systemName: "heart")
                                    .foregroundColor(.labelsPrimary)
                                    .font(.system(size: 28))
                                    .padding(.all, 8)
                                    .frame(width: 50, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(.gray5))
                            }
                            , alignment: .topTrailing)
                
        }
        .padding(.all)
        .frame(maxWidth: 300, maxHeight: 300)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundsSecondary)
        )
        
    }
}

#Preview {
    ProductDetailsImage(
        product: Product(
            id: 1,
            title: "Example Product",
            price: 99.99,
            thumbnail: "https://via.placeholder.com/150"
        )
    )
}
