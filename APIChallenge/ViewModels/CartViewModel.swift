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
    private let orderService: any OrderServiceProtocol
    
    init(cartService: any CartServiceProtocol, productService: ProductServiceProtocol, orderService: OrderServiceProtocol) {
        self.cartService = cartService
        self.productService = productService
        self.orderService = orderService
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
            print(cartProduct.product)
            print(cartProduct.quantity)
            print(cartProduct.product.price)
            totalPrice += Double(cartProduct.quantity) * cartProduct.product.price
        }
        
        return totalPrice
    }
    
    func increaseQuantity(for cartProduct: CartProduct) {
        do {
            if let item = try cartService.getCartProductIds().first(where: { $0.productId == cartProduct.id }) {
                //no banco
                try cartService.updateCartProductId(item, quantity: item.quantity + 1)
                
                //na aplicacao
                if let index = cartProducts.firstIndex(where: { $0.id == cartProduct.id }) {
                    cartProducts[index].quantity += 1
                }
            }
        } catch {
            
        }
    }
    
    func decreaseQuantity(for cartProduct: CartProduct) {
        do {
            if let item = try cartService.getCartProductIds().first(where: { $0.productId == cartProduct.id }) {
                //no banco
                try cartService.updateCartProductId(item, quantity: item.quantity - 1)
                
                //na aplicacao
                if let index = cartProducts.firstIndex(where: { $0.id == cartProduct.id }) {
                    cartProducts[index].quantity -= 1
                }
            }
        } catch {
            
        }
    }
    
    func checkout() {
        do {
            
            try orderService.addProductOrder(products: cartProducts)

        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addProductInCart(product: CartProduct) {
        do {
            try cartService.addCartProductId(CartProductID(productId: product.id, quantity: product.quantity))
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
