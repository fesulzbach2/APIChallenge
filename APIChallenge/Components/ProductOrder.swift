//
//  ContentView.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 13/08/25.
//

import SwiftUI

struct ProductOrder: View {
    
    var orderedProduct: OrderedProduct
    
    private var accessibilityText: String {
        let total = Double(orderedProduct.productPrice) * Double(orderedProduct.productQuantity)
        let totalFormatted = String(format: "%.2f", total)
        return "\(orderedProduct.productTitle) for \(totalFormatted) dollars"
    }
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            AsyncImage(url: URL(string: orderedProduct.productThumbnail)) { image in
                            image.resizable()
                        } placeholder: {
                            Image(.placeholder)
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
                    
                    Text(orderedProduct.productShippingInformation.uppercased())
                        .fontWeight(.regular)
                        .font(.system(size: 12))
                        .foregroundStyle(.labelsSecondary)
                    
                    Text(orderedProduct.productTitle)
                        .fontWeight(.regular)
                        .font(.system(size: 13))
                    
                    
                    Text("US$\(orderedProduct.productPrice.formatted(.number.precision(.fractionLength(2))))")
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 62)
                
            }
            .accessibilityLabel(accessibilityText)
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
