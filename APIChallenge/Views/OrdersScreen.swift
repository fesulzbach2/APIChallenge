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
    
    var body: some View {
        
        NavigationStack {
            
                VStack{
                    
                    if(viewModel.orderedProducts.isEmpty) {
                        
                        EmptyState(icon: "suitcase", headerText: "No orders yet!", footerText: "Buy an item and it will show up here.")
                    } else {
                        ForEach(viewModel.orderedProducts) {product in
                            ProductOrder(orderedProduct: product)
                                .padding(.top, 16)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                        }
                        .scrollContentBackground(.hidden)
                        .listStyle(.plain)

                    }
                    
                }
                .padding(.horizontal)
                .scrollIndicators(.hidden)
                .navigationTitle("Orders")
                .searchable(text: $searchText)
                
            
            
            
            
        }
        .toolbarBackground(.backgroundsPrimary, for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)

         
    }
        
}

#Preview {
    TabBar()
}
