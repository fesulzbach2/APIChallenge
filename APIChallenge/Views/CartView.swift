//
//  CartScreen.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 18/08/25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct CartView: View {
    
    var viewModel: CartViewModel
    
//    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack {
            Spacer()
            if viewModel.cartProducts.isEmpty {
                EmptyState(icon: "cart.badge.questionmark", headerText: "Your cart is empty!", footerText: "Add an item to your cart.")
                Spacer()
            } else {
                ScrollView {
                    ForEach(viewModel.cartProducts) { cartProduct in
                        ProductCart(product: cartProduct.product,
                                    quantity: cartProduct.quantity,
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
                viewModel.checkout()
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
        }
        .padding(.vertical, 16)
    }
}

#Preview {
    TabBar()
}
