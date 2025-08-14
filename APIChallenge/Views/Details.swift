//
//  EmptyState.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 14/08/25.
//


import SwiftUI

struct Details: View {
    
    @Binding var product: Product
    
    @State var empty: Bool = false
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                
                VStack (alignment: .leading, spacing: 16) {
                    ProductDetailsImage(product: $product)
                        .frame(maxHeight: 360)
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(product.title)
                            .fontWeight(.regular)
                            .font(.system(size: 20))
                        
                        Text("US$\(product.price.formatted(.number.precision(.fractionLength(2))))")
                        .fontWeight(.bold)
                        .font(.system(size: 22))
                    }
                    
                    Text(product.description)
                        .fontWeight(.regular)
                        .font(.system(size: 17))
                        .foregroundStyle(.labelsSecondary)
                }
                
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Details")
            .toolbarBackground(.backgroundsPrimary, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            
        }
         
    }
        
}

#Preview {
    @State var previewProduct = Product(
        id: 1,
        title: "Example ProductExample",
        description: "okkkk",
        price: 99.9,
        thumbnail: "https://via.placeholder.com/150",
        category: "Beauty",
        shippingInformation: "Delivery blabla"
    )
    
    return Details(product: $previewProduct)
}

