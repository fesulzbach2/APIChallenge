//
//  CartViewModel.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 20/08/25.
//

import Foundation

@Observable
class CartViewModel {
    
    var cartProducts: [CartProduct] = []
    var errorMessage: String?
    var totalPrice: Double {
        calculateTotalPrice()
    }
    
    private let cartService: any CartServiceProtocol
    private let productService: any ProductServiceProtocol
    
    init(cartService: any CartServiceProtocol, productService: ProductServiceProtocol) {
        self.cartService = cartService
        self.productService = productService
    }
    
    func getCartProducts() async {
        
        do {
            
            let cartProductIds: [CartProductID] = try cartService.getCartProductIds()
            let ids = cartProductIds.map { $0.productId }
            
            let produts: [Product] = try await productService.fetchProducts(for: ids)
            
            var cartProducts: [CartProduct] = []
            
            for product in produts {
                guard let item = cartProductIds.first(where: { $0.productId == product.id}) else { continue }
                let quantity = item.quantity
                let cartProduct = CartProduct(id: product.id, product: product, quantity: quantity)
                cartProducts.append(cartProduct)
            }
            
            self.cartProducts = cartProducts
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
    }
    
    func calculateTotalPrice() -> Double {
        var totalPrice = 0.0
        
        for cartProduct in cartProducts {
            totalPrice += Double(cartProduct.quantity) * cartProduct.product.price
        }
        
        return totalPrice
    }
    
    func increaseQuantity(for cartProduct: CartProduct) {
        // servico avisando que é para aumentar a quantidade desse item
    }
    
    func decreaseQuantity(for cartProduct: CartProduct) {
        // servico avisando que é para diminuir a quantidade desse item
    }
    
    
}
