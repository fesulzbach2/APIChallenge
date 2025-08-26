//
//  OrderViewModel.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 21/08/25.
//

import Foundation

@Observable
class OrderViewModel {
    
    var orderedProducts: [OrderedProduct] = []
    var errorMessage: String?
    
    private let cartService: any CartServiceProtocol
    private let productService: any ProductServiceProtocol
    private let orderedService: any OrderServiceProtocol
    
    init(cartService: any CartServiceProtocol, productService: any ProductServiceProtocol, orderService: any OrderServiceProtocol) {
        self.cartService = cartService
        self.productService = productService
        self.orderedService = orderService
    }
    
    func getOrderedProducts() async {
        do {
            self.orderedProducts = try orderedService.fetchProductsOrder()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func cleanOrders() {
        do {
            try orderedService.cleanOrders()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

//
//    func addProductOrder(_ OrderedProduct: [OrderedProduct]) {
////        orderedProducts.append(contentsOf: cartProducts)
//        do {
//            try orderedService.addProductOrder(products: OrderedProduct)
//        } catch {
//            errorMessage = error.localizedDescription
//        }
//    }

}

