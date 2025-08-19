//
//  EmptyState.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 14/08/25.
//


import SwiftUI
import SwiftData

struct OrdersView: View {
    
    
    @Environment(\.modelContext) var modelContext
    
    @Query var OrderedProducts: [OrderedProduct]
    
    
    var icon: String = "cart.badge.questionmark"
    var headerText: String = "Your cart is empty!"
    var footerText: String = "Add an item to your cart."
    
    @State var empty: Bool = false
    
    @State private var selectedProduct: Product?
    
    var body: some View {
        
        NavigationStack {
            
                VStack{
                    
                    if(empty) {
                        
                        EmptyState(icon: "suitcase", headerText: "No orders yet!", footerText: "Buy an item and it will show up here.")
                    } else {
                        List(OrderedProducts) { product in
                            ProductOrder(product: product)
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
                .searchable(text: .constant(""))
                
            
            
            
            
        }
        .toolbarBackground(.backgroundsPrimary, for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)

         
    }
        
}

#Preview {
    TabBar()
}
