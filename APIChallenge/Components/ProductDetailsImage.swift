//
//  ContentView.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 13/08/25.
//

import SwiftUI
import SwiftData

struct ProductDetailsImage: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Binding var product: Product
    
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
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            Button {
                                favoriteProduct()
                        
                            } label: {
                                Image(systemName: product.isFavorite ? "heart.fill" : "heart")
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundsSecondary)
        )
        
    }
    
    func favoriteProduct() -> Void {
        
        if product.isFavorite {
            
            let fetchDescriptor = FetchDescriptor<FavoritedProduct> (
                       predicate: #Predicate { $0.id == product.id }
                   )
            
            if let stored = try? modelContext.fetch(fetchDescriptor).first {
                        modelContext.delete(stored)
                        try? modelContext.save()
                    }
            
        } else {
            
            let newStoredProduct = FavoritedProduct(id: product.id)
            modelContext.insert(newStoredProduct)
            try? modelContext.save()
        }
        
        product.isFavorite.toggle()
        
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
