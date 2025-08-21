////
////  EmptyState.swift
////  APIChallenge
////
////  Created by Fernando Sulzbach on 14/08/25.
////
//
//
//import SwiftUI
//
//struct OrdersView: View {
//    
//    @State var viewModel: ProductViewModel
//    
//    var icon: String = "cart.badge.questionmark"
//    var headerText: String = "Your cart is empty!"
//    var footerText: String = "Add an item to your cart."
//    
//    @State var empty: Bool = false
//    
//    @State private var selectedProduct: Product?
//    
//    var body: some View {
//        
//        NavigationStack {
//            
//            if viewModel.isLoading {
//                ProgressView()
//
//            } else if let error = viewModel.errorMessage {
//                Text(error)
//                    .foregroundStyle(.red)
//            } else {
//                VStack{
//                    
//                    if(empty) {
//                        
//                        EmptyState(icon: "suitcase", headerText: "No orders yet!", footerText: "Buy an item and it will show up here.")
//                    } else {
//                        List(viewModel.products) { product in
//                            ProductOrder(product: product)
//                                .padding(.top, 16)
//                                .listRowInsets(EdgeInsets())
//                                .listRowSeparator(.hidden)
//                                .onTapGesture {
//                                    selectedProduct = product
//                                }
//                        }
//                        .scrollContentBackground(.hidden)
//                        .listStyle(.plain)
//                        .refreshable {
//                            await viewModel.loadProducts()
//                        }
//                    }
//                    
//                }
//                .padding(.horizontal)
//                .scrollIndicators(.hidden)
//                .navigationTitle("Orders")
//                .searchable(text: .constant(""))
//                
//            }
//            
//            
//            
//        }
//        .toolbarBackground(.backgroundsPrimary, for: .tabBar)
//        .toolbarBackgroundVisibility(.visible, for: .tabBar)
//        
//        .sheet(item: $selectedProduct) { product in
//            if let index = viewModel.products.firstIndex(where: { $0.id == product.id }) {
//                Details(product: $viewModel.products[index])
//                    .presentationDragIndicator(.visible)
//            }
//        }
//        
//        .task {
//            await viewModel.loadProducts()
//        }
//
//         
//    }
//        
//}
//
//#Preview {
//    TabBar()
//}
