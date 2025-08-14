//
//  EmptyState.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 14/08/25.
//


import SwiftUI

struct Orders: View {
    
    let viewModel: ProductViewModel
    
    var icon: String = "cart.badge.questionmark"
    var headerText: String = "Your cart is empty!"
    var footerText: String = "Add an item to your cart."
    
    @State var empty: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            if viewModel.isLoading {
                ProgressView()

            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            } else {
                VStack{
                    
                    if(empty) {
                        
                        EmptyState(icon: "suitcase", headerText: "No orders yet!", footerText: "Buy an item and it will show up here.")
                    } else {
                        List(viewModel.products) { product in
                            ProductOrder(product: product, category: .Beauty)
                               .padding(.top, 16)
                                .scrollContentBackground(.hidden)
                                .listStyle(.plain)
                                .listRowInsets(EdgeInsets())
                        }
                      //  .padding(.vertical)
                        .listRowSeparator(.hidden)
                        .listStyle(.plain)
                        .listRowInsets(EdgeInsets())
                        .refreshable {
                            await viewModel.loadProducts()
                        }
                    }
                    
                }
                .padding(.horizontal)
                .scrollIndicators(.hidden)
                .navigationTitle("Orders")
                .searchable(text: .constant(""))
                
            }
            
            
            
        }
        .toolbarBackground(.backgroundsPrimary, for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        
        .task {
            await viewModel.loadProducts()
        }

         
    }
        
}

#Preview {
    TabBar()
}
