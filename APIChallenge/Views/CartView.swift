//
//  CartScreen.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 18/08/25.
//

import SwiftUI
import _SwiftData_SwiftUI

struct CartView: View {
    @Environment(\.modelContext) private var context
    @Query var orders: [Order]
    @State private var products: [Product] = []
    let service = ProductService()
    
    
    var body: some View {
        VStack {
            if orders.isEmpty {
                EmptyState(icon: "cart.badge.questionmark", headerText: "Your cart is empty!", footerText: "Add an item to your cart.")
            } else {
                ScrollView {
                    ForEach(orders) { product in
                        ForEach(product.products) { item in
                            if let productAPI = products.first(where: { $0.id == item.productId }) {
                                HStack {
                                    ProductCart(product: productAPI, quantity: item.quantity)
                                }
                            } else {
                                
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            Button("Adicionar pedido de teste"){
                let product1 = ProductToCart(productId: 14, quantity: 4)
                let product2 = ProductToCart(productId: 19, quantity: 2)
                let order = Order(products: [product1, product2])
                
                context.insert(order)
                try? context.save()
            }
            
            Button("Limpar produtos") {
                for order in orders {
                    context.delete(order)
                }
                try? context.save()
            }
        }
        .navigationTitle("Cart")
        .navigationBarTitleDisplayMode(.large)
        .task {
            do {
                products = try await service.fetchProducts()
            } catch {
                print("Erro ao buscar produtos: \(error)")
            }
        }
        .padding(.top, 16)
    }
}

#Preview {
    TabBar()
}
