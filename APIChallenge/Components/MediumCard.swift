//
//  MediumCard.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 13/08/25.
//
import SwiftUI

struct MediumCard: View {
    var isHorizontal : Bool?
    let category: Categories
    let text: String
    let price: Double //alterar de ponto pra virgula
    @State private var isFavorite = false
    
    func content() -> some View {
        let spec = Fonts.specs(for: .subheadlineRegular)
        let twoLineMinHeight = spec.lineHeight * 2
        
        return VStack(alignment: .leading){
            Text(text)
                .typography(.subheadlineRegular)
                .foregroundStyle(.labelsPrimary)
                .lineLimit(2)
                .frame(minHeight: twoLineMinHeight, alignment: .leading)
            Text("US$\(String(format: "%.2f", price))")
                .typography(.headline)
                .foregroundStyle(.labelsPrimary)
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func toggleFavorite(product: String) {
        print("working")
    }
    
    var body: some View {
        ZStack {
            if isHorizontal == true {
                HStack( alignment: .center, spacing: 16) {
                    category.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(alignment: .leading){
                        HStack(alignment: .center){
                            Text(category.rawValue.uppercased(with: .autoupdatingCurrent))
                                .typography(.footnoteRegular)
                                .foregroundStyle(.labelsSecondary)
                            
                            Spacer()
                            
                            FavoriteIcon(fill: $isFavorite, action: {toggleFavorite(product: "product")})
                        }
                        
                        content()
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
            } else {
                VStack(alignment: .leading) {
                    ZStack(alignment: .topTrailing) {
                        category.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160, height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        FavoriteIcon(fill: $isFavorite, action: {toggleFavorite(product: "product")})
                        
                    }
                    content()
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
            }
        }
        .background(.backgroundsSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    MediumCard(isHorizontal: false, category: .Beauty, text: "Product name with two or more lines goes here", price: 0.0)
}
