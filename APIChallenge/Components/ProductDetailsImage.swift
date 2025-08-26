//
//  ContentView.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 13/08/25.
//

import SwiftUI
import SwiftData

struct ProductDetailsImage: View {
        
    @Binding var product: Product
    
    var action: () -> Void
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                            image.resizable()
                        } placeholder: {
                            Image(.placeholder)
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .frame(alignment: .leading)
                        }
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            Button {
                                action()
                                product.isFavorite.toggle()

                        
                            } label: {
                                Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(.labelsPrimary)
                                    .font(.system(size: 28))
                                    .padding(.all, 8)
                                    .frame(width: 50, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(.gray5))
                                    .accessibilityLabel(product.isFavorite ? "\(product.title) Favorited. Double click to change" : "\(product.title) Not Favorited. Double click to change")
                            }
                            , alignment: .topTrailing)
                
        }
        .padding(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundsSecondary)
        )
        
    }
    


}

//#Preview {
//    ProductDetailsImage(
//        product: Product(
//            id: 1,
//            title: "Example Product",
//            price: 99.99,
//            thumbnail: "https://via.placeholder.com/150",
//            category: "Beauty",
//            shippingInformation: "Delivery blabla"
//        )
//    )
//}
