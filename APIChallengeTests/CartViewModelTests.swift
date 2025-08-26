//
//  CartViewModelTests.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 26/08/25.
//

import Testing
@testable import APIChallenge

@Suite("Testes do CartViewModel")
struct CartViewModelTests {
    
    @Test("getCartProducts deve carregar corretamente os itens do carrinho")
    func getCartProducts_success() async throws {
        // Given
        let mockCart = [CartProduct(productId: 1, quantity: 2)]
        let cartService = MockCartService(initialCart: mockCart)
        let productService = MockProductService()
        let orderService = MockOrderService()
        
        var viewModel = CartViewModel(
            cartService: cartService,
            productService: productService,
            orderService: orderService
        )
        
        // When
        let result = await viewModel.getCartProducts()
        
        // Then
        #expect(result.count == 1)
        #expect(result.first?.quantity == 2)
        #expect(viewModel.productsInCart.count == 1)
        #expect(viewModel.productsInCart.first?.id == 1)
    }
    
    @Test("getCartProducts com falha deve definir errorMessage")
    func getCartProducts_failure() async {
        let cartService = MockCartService(shouldFail: true)
        let productService = MockProductService()
        let orderService = MockOrderService()
        
        var viewModel = CartViewModel(
            cartService: cartService,
            productService: productService,
            orderService: orderService
        )
        
        let result = await viewModel.getCartProducts()
        
        #expect(result.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test("increaseQuantity deve incrementar a quantidade do produto")
    func increaseQuantity_success() async throws {
        let cartService = MockCartService(initialCart: [CartProduct(productId: 1, quantity: 1)])
        let productService = MockProductService()
        let orderService = MockOrderService()
        
        var viewModel = CartViewModel(
            cartService: cartService,
            productService: productService,
            orderService: orderService
        )
        await viewModel.getCartProducts()
        
        let product = viewModel.productsInCart.first!
        viewModel.increaseQuantity(for: product)
        
        #expect(viewModel.getQuantity(by: 1) == 2)
    }
    
    @Test("decreaseQuantity deve decrementar a quantidade do produto")
    func decreaseQuantity_success() async throws {
        let cartService = MockCartService(initialCart: [CartProduct(productId: 1, quantity: 3)])
        let productService = MockProductService()
        let orderService = MockOrderService()
        
        var viewModel = CartViewModel(
            cartService: cartService,
            productService: productService,
            orderService: orderService
        )
        await viewModel.getCartProducts()
        
        let product = viewModel.productsInCart.first!
        viewModel.decreaseQuantity(for: product)
        
        #expect(viewModel.getQuantity(by: 1) == 2)
    }
    
    @Test("calculateTotalPrice deve retornar o valor correto")
    func calculateTotalPrice_success() async throws {
        let cartService = MockCartService(initialCart: [
            CartProduct(productId: 1, quantity: 2),
            CartProduct(productId: 2, quantity: 1)
        ])
        let productService = MockProductService(shouldFail: false)
        let orderService = MockOrderService()
        
        var viewModel = CartViewModel(
            cartService: cartService,
            productService: productService,
            orderService: orderService
        )
        await viewModel.getCartProducts()
        
        let total = viewModel.calculateTotalPrice()
        
        // Produtos mockados: id 1 -> 10.50, id 2 -> 10.0
        // total = (2 * 10.50) + (1 * 10.0) = 31.0
        #expect(total == 31.0)
    }
    
    @Test("checkout deve criar pedidos no orderService e limpar o carrinho")
    func checkout_success() async throws {
        let cartService = MockCartService(initialCart: [CartProduct(productId: 1, quantity: 2)])
        let productService = MockProductService()
        let orderService = MockOrderService()
        
        var viewModel = CartViewModel(
            cartService: cartService,
            productService: productService,
            orderService: orderService
        )
        await viewModel.getCartProducts()
        
        viewModel.checkout(products: viewModel.cartProducts)
        
        let orders = try orderService.fetchProductsOrder()
        
        #expect(orders.count == 1)
        #expect(viewModel.cartProducts.isEmpty)
        #expect(viewModel.productsInCart.isEmpty)
    }
    
    @Test("cleanCart deve esvaziar carrinho e produtos")
    func cleanCart_success() async throws {
        let cartService = MockCartService(initialCart: [CartProduct(productId: 1, quantity: 1)])
        let productService = MockProductService()
        let orderService = MockOrderService()
        
        var viewModel = CartViewModel(
            cartService: cartService,
            productService: productService,
            orderService: orderService
        )
        await viewModel.getCartProducts()
        
        viewModel.cleanCart()
        
        #expect(viewModel.cartProducts.isEmpty)
        #expect(viewModel.productsInCart.isEmpty)
    }
}
