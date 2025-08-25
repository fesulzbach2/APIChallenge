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
    var productsInCart: [Product] = []
    
    private let cartService: any CartServiceProtocol
    private let productService: any ProductServiceProtocol
    private let orderService: any OrderServiceProtocol
    
    init(cartService: any CartServiceProtocol, productService: ProductServiceProtocol, orderService: OrderServiceProtocol) {
        self.cartService = cartService
        self.productService = productService
        self.orderService = orderService
    }
    
    func getCartProducts() async -> [CartProduct] {
        do {
            
            let cartProductIds: [CartProduct] = try cartService.getCartProductIds()
            let ids = cartProductIds.map { $0.productId }
            
            let produts: [Product] = try await productService.fetchProducts(for: ids)
            
            var cartProducts: [CartProduct] = []
            
            for product in produts {
                guard let item = cartProductIds.first(where: { $0.productId == product.id}) else { continue }
                let quantity = item.quantity
                let cartProduct = CartProduct(productId: product.id, quantity: quantity)
                cartProducts.append(cartProduct)
                if !productsInCart.contains(where: {$0.id == item.productId}) {
                    productsInCart.append(product)
                }
            }
            
            self.cartProducts = cartProducts
            
        } catch {
            errorMessage = error.localizedDescription
        }
        return cartProducts
    }
    
    func getQuantity(by id: Int) -> Int {
        return cartProducts.first(where: { $0.productId == id })?.quantity ?? 1
    }
    
    func calculateTotalPrice() -> Double {
        var totalPrice = 0.0
        
        for cart in cartProducts {
            if let product = productsInCart.first(where: { $0.id == cart.productId }) {
                totalPrice += Double(cart.quantity) * product.price
            }
        }
        
        return totalPrice
    }
    
    func increaseQuantity(for cartProduct: Product) {
        do {
            if let item = try cartService.getCartProductIds().first(where: { $0.productId == cartProduct.id }) {
                //no banco
                try cartService.updateCartProductId(item, quantity: item.quantity + 1)
                
                //na aplicação
                if let index = cartProducts.firstIndex(where: { $0.productId == cartProduct.id }) {
                    cartProducts[index].quantity += 1
                }
            }
        } catch {
            
        }
    }
    
    func decreaseQuantity(for cartProduct: Product) {
        do {
            if let item = try cartService.getCartProductIds().first(where: { $0.productId == cartProduct.id }) {
                //no banco
                try cartService.updateCartProductId(item, quantity: item.quantity - 1)
                
                //na aplicação
                if let index = cartProducts.firstIndex(where: { $0.productId == cartProduct.id }) {
                    cartProducts[index].quantity -= 1
                }
            }
        } catch {
            
        }
    }
    
    func checkout(products: [CartProduct]) {
        do {
            var ordered: [OrderedProduct] = []
            
            for cart in cartProducts {
                if let product = productsInCart.first(where: { $0.id == cart.productId }) {
                    let orderedProduct = OrderedProduct(
                        productId: product.id,
                        productTitle: product.title,
                        productDetails: product.details,
                        productPrice: product.price * Double(cart.quantity),
                        productThumbnail: product.thumbnail,
                        productCategory: product.category,
                        productShippingInformation: product.shippingInformation,
                        productQuantity: cart.quantity
                    )
                    ordered.append(orderedProduct)
                    
                    print("product: \(product.title) quantity: \(cart.quantity)")
                }
            }
            
            try orderService.addProductOrder(products: ordered)
            cleanCart()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addProductInCart(id: Int) {
        do {
            try cartService.addCartProductId(id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func cleanCart() {
        do {
            cartService.cleanCart()
            cartProducts.removeAll()
            productsInCart.removeAll()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

}
