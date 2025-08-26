//
//  CartScreen.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 18/08/25.
//

import SwiftUI
import SwiftData

struct CartView: View {
    
    var viewModel: CartViewModel
//    var products: [CartProduct]
        
    var body: some View {
        VStack {
            Spacer()
            if viewModel.cartProducts.isEmpty {
                EmptyState(icon: "cart.badge.questionmark", headerText: "Your cart is empty!", footerText: "Add an item to your cart.")
                Spacer()
            } else {
                ScrollView {
                    ForEach(viewModel.productsInCart) { cartProduct in
                        ProductCart(product: cartProduct,
                                    quantity: viewModel.getQuantity(by: cartProduct.id),
                                    increaseQuantity: {viewModel.increaseQuantity(for: cartProduct)},
                                    decreaseQuantity: {viewModel.decreaseQuantity(for: cartProduct)}
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
            
            Spacer()
            
            HStack {
                Text("Total:")
                Spacer()
                Text("US$\(String(format: "%.2f", viewModel.totalPrice))")
                    .typography(.headline)
            }
            .padding(.horizontal, 16)
            
            Button {
                viewModel.checkout(products: viewModel.cartProducts)
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.fillsTertiary)
                        .frame(height: 54)
                        .frame(width: 361)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    Text("Checkout")
                        .foregroundStyle(.labelsPrimary)
                        .typography(.bodyEmphasized)
                }
            }
        }
        .navigationTitle("Cart")
        .navigationBarTitleDisplayMode(.large)
        .task {
            await viewModel.getCartProducts()
            print("quantas coisas tem no carrinho:")
            print(viewModel.productsInCart.count)
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    TabBar()
}
