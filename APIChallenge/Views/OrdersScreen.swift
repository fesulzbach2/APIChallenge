//
//  EmptyState.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 14/08/25.
//


import SwiftUI
import SwiftData

struct OrdersView: View {
    
    
    var viewModel: OrderViewModel
    
    @State private var searchText = ""
    
    var filteredProducts: [OrderedProduct] {
        if searchText.isEmpty {
            return viewModel.orderedProducts
        } else {
            return viewModel.orderedProducts.filter { product in
                product.productTitle.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    if(viewModel.orderedProducts.isEmpty) {
                        EmptyState(icon: "suitcase", headerText: "No orders yet!", footerText: "Buy an item and it will show up here.")
                    } else {
                        
                        ForEach(filteredProducts) { product in
                            ProductOrder(orderedProduct: product)
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.plain)
                        
                        
                        //temporario para ajudar a depurar
//                        Button("clean") {
//                            viewModel.cleanOrders()
//                        }
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                .scrollIndicators(.hidden)
                .navigationTitle("Orders")
                .searchable(text: $searchText)
            }
        }
        .toolbarBackground(.backgroundsPrimary, for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .task {
            await viewModel.getOrderedProducts()
        }
        
    }
}

#Preview {
    TabBar()
}
