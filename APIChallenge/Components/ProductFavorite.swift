//
//  ContentView.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 13/08/25.
//

import SwiftUI

struct ProductFavorite: View {
    
    var category: Categories = .Beauty
    var name: String = "Product name with two or more lines goes here"
    var price: Double = 0.5
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            category.image
                .resizable()
                .frame(width: 78, height: 78)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(alignment: .leading)
            
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text(name)
                        .fontWeight(.regular)
                        .font(.system(size: 13))
                        .frame(height: 36)
                    
                    
                    Text("US$\(price.formatted(.number.precision(.fractionLength(2))))")
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 62)
                
                VStack(alignment: .trailing) {
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName: "cart.fill")
                            .foregroundStyle(.labelsPrimary)
                            .frame(width: 22, height: 22)
                            .font(.system(size: 17))
                            .padding(.all, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.fillsTertiary)
                            )
                            .foregroundStyle(.white)
                    }
                    
                    
                }
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

#Preview {
    ProductFavorite()
}
