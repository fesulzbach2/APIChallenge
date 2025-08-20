//
//  EmptyState.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 14/08/25.
//


import SwiftUI
import SwiftData

struct Details: View {
    
    @Environment(\.modelContext) private var context
    
    @Binding var product: Product
    @State var empty: Bool = false
//    @Query var orders: [Order]
    @State private var products: [Product] = []
    let service = ProductService()
    let cartService = CartService()
    
    var body: some View {
        
        NavigationStack {
            VStack {
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
                .scrollIndicators(.hidden)
                .background(.backgroundsPrimary)
                
                VStack {
                    Button {
                        
//                        let newOrderedProduct = OrderedProduct(id: product.id,
//                                                               title: product.title,
//                                                               productDescription: product.description,
//                                                               price: product.price,
//                                                               thumbnail: product.thumbnail,
//                                                               category: product.category,
//                                                               shippingInformation: product.shippingInformation
//                                                               )
//                        modelContext.insert(newOrderedProduct)
//                        if let order = orders.first {
//                            let save = CartProductID(productId: product.id, quantity: 1)
//                            order.products.append(save)
//                        } else {
//                            let save = CartProductID(productId: product.id, quantity: 1)
//                            let newOrder = Order(products: [save])
//                            context.insert(newOrder)
//                        }
                        
                        let cartProductID = CartProductID(productId: product.id, quantity: 1)
                        cartService.addCartProductId(cartProductID)
                        
                    } label: {
                        Text("Add to Cart")
                            .fontWeight(.semibold)
                            .font(.system(size: 17))
                            .foregroundColor(.labelsPrimary)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.fillsTertiary))
                    }
                }
                .padding(.top)
               // .frame(height: 86)
            }
            .padding(.horizontal)
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Details")
            .toolbarBackground(.backgroundsSecondary, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            
        }
         
    }
        
}

//#Preview {
//    @State var previewProduct = Product(
//        id: 1,
//        title: "Example ProductExample",
//        description: "okkkk",
//        price: 99.9,
//        thumbnail: "https://via.placeholder.com/150",
//        category: "Beauty",
//        shippingInformation: "Delivery blabla"
//    )
//    
//    return Details(product: $previewProduct)
//}

