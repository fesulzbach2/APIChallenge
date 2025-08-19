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
    
    var filteredOrderedProducts: [OrderedProduct] {
        if searchText.isEmpty {
            return OrderedProducts
        } else {
            return OrderedProducts.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    @State var empty: Bool = false
    
    @State private var selectedProduct: Product?
    
    @State private var searchText = ""
    
    var body: some View {
        
        NavigationStack {
            
                VStack{
                    
                    if(filteredOrderedProducts.isEmpty) {
                        
                        EmptyState(icon: "suitcase", headerText: "No orders yet!", footerText: "Buy an item and it will show up here.")
                    } else {
                        List(filteredOrderedProducts) { product in
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
                .searchable(text: $searchText)
                
            
            
            
            
        }
        .toolbarBackground(.backgroundsPrimary, for: .tabBar)
        .toolbarBackgroundVisibility(.visible, for: .tabBar)

         
    }
        
}

#Preview {
    TabBar()
}
