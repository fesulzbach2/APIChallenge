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
    
    var body: some View {
        VStack {
            if viewModel.cartProducts.isEmpty {
                EmptyState(icon: "cart.badge.questionmark", headerText: "Your cart is empty!", footerText: "Add an item to your cart.")
            } else {
                ScrollView {
                    ForEach(viewModel.cartProducts) { cartProduct in
                        ProductCart(product: cartProduct.product,
                                    quantity: cartProduct.quantity,
                                    increaseQuantity: {viewModel.increaseQuantity(for: cartProduct)},
                                    decreaseQuantity: {viewModel.decreaseQuantity(for: cartProduct)})
                    }
                }
                .padding(.horizontal, 16)
            }

            
//            Button("Adicionar pedido de teste"){
//                let product1 = ProductToCart(productId: 14, quantity: 4)
//                let product2 = ProductToCart(productId: 19, quantity: 2)
//                let order = Order(products: [product1, product2])
//                
//                context.insert(order)
//                try? context.save()
//            }
//            
//            Button("Limpar produtos") {
//                for order in orders {
//                    context.delete(order)
//                }
//                try? context.save()
//            }
            
            HStack {
                Text("Total:")
                Spacer()
                Text("\(viewModel.totalPrice)")
            }
        }
        .navigationTitle("Cart")
        .navigationBarTitleDisplayMode(.large)
        .task {
            await viewModel.getCartProducts()
        }
        .padding(.top, 16)
    }
}

#Preview {
    TabBar()
}
