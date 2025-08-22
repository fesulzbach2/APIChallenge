//
//  MediumCard.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 13/08/25.
//
import SwiftUI

struct MediumCard: View {
    
    var isHorizontal : Bool
    @Binding var product: Product
    var action: () -> Void
    
    @State private var showDetails = false
    
    func content() -> some View {
        let spec = Fonts.specs(for: .subheadlineRegular)
        let twoLineMinHeight = spec.lineHeight * 2
        
        return VStack(alignment: .leading){
            Text(product.title)
                .typography(.subheadlineRegular)
                .foregroundStyle(.labelsPrimary)
                .lineLimit(2)
                .frame(minHeight: twoLineMinHeight, alignment: .leading)
            Text("US$\(String(format: "%.2f", product.price))")
                .typography(.headline)
                .foregroundStyle(.labelsPrimary)
                .padding(.top, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    func image() -> some View {
        AsyncImage(url: URL(string: product.thumbnail)) { image in
            image
                .resizable()
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 12))
        } placeholder: {
            Image(.placeholder)
                .resizable()
                .frame(alignment: .leading)
            
        }
       // .frame(width: 160, height: 160)
        .frame(height: 160)
        .frame(maxWidth: .infinity)
        
        
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    var body: some View {
        Button {
            showDetails = true
        } label: {
            ZStack {
                if isHorizontal == true {
                    HStack( alignment: .center, spacing: 16) {
                        
                        image()
                        
                        VStack(alignment: .leading){
                            HStack(alignment: .center){
                                Text(product.category.uppercased(with: .autoupdatingCurrent))
                                    .typography(.footnoteRegular)
                                    .foregroundStyle(.labelsSecondary)
                                
                                Spacer()
                                
                                FavoriteIcon(product: $product, action: { action() })
                            }
                            
                            content()
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 8)
                } else {
                    VStack(alignment: .leading) {
                        ZStack(alignment: .topTrailing) {
                            
                            image()
                            
                            FavoriteIcon(product: $product, action: { action() })
                            
                        }
                        content()
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 8)
                }
            }
        }
        .background(.backgroundsSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .sheet(isPresented: $showDetails) {
            Details(viewModel: DetailsViewModel(productService: ProductService(), favoriteService: FavoritesService()), product: $product)
                }
    }
}

#Preview {
    TabBar()
}
