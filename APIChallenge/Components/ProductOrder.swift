//
//  ContentView.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 13/08/25.
//

import SwiftUI

struct ProductOrder: View {
    
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
                                .frame(width: 78, height: 78)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .frame(alignment: .leading)
                            
                        }
                        .frame(width: 78, height: 78)
                        .frame(alignment: .leading)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(deliveryDate)
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                        .foregroundStyle(.labelsSecondary)
                    
                    Text(product.title)
                        .fontWeight(.regular)
                        .font(.system(size: 13))
                    
                    
                    Text("US$\(product.price.formatted(.number.precision(.fractionLength(2))))")
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 62)
                
            }
        }
        .padding(.vertical, 8)
        .padding(.leading, 8)
        .padding(.trailing, 16)
        .frame(maxWidth: .infinity)
        .frame(height: 94)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundsSecondary)
        )
        
    }
}

//#Preview {
//    ProductOrder()
//}
