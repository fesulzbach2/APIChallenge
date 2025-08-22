//
//  EmptyState.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 14/08/25.
//


import SwiftUI
import SwiftData

struct Details: View {
    
//    @Environment(\.modelContext) private var context
    
    @Binding var product: Product
    var cartViewModel: CartViewModel = CartViewModel(cartService: CartService(), productService: ProductService(), orderService: OrderService())
    
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
                        
                        Text(product.details)
                            .fontWeight(.regular)
                            .font(.system(size: 17))
                            .foregroundStyle(.labelsSecondary)
                    }
                    
                }
                .scrollIndicators(.hidden)
                .background(.backgroundsPrimary)
                
                VStack {
                    Button {
                        cartViewModel.addProductInCart(product: CartProduct(id: product.id, product: product, quantity: 1))
                        
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
//            .task {
////                await cartViewModel.getCartProducts()
//            }
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

