//
//  OrderViewModelTests.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 26/08/25.
//

import Testing
@testable import APIChallenge

struct OrderViewModelTests {
    
    @Test("Deve buscar pedidos com sucesso")
    func test_getOrderedProducts_success() async throws {
        let order = OrderedProduct(productId: 1, productTitle: "Produto 1", productDetails: "Detalhes", productPrice: 10.0, productThumbnail: "", productCategory: "", productShippingInformation: "", productQuantity: 2)
        let mockOrderService = MockOrderService(initialOrders: [order])
        
        let viewModel = OrderViewModel(
            cartService: MockCartService(),
            productService: MockProductService(shouldFail: false),
            orderService: mockOrderService
        )
        
        await viewModel.getOrderedProducts()
        
        #expect(viewModel.orderedProducts.count == 1)
        #expect(viewModel.orderedProducts.first?.id == order.id)
    }
    
    @Test("Deve setar mensagem de erro ao falhar em buscar pedidos")
    func test_getOrderedProducts_failure() async throws {
        let mockOrderService = MockOrderService(shouldFail: true)
        
        let viewModel = OrderViewModel(
            cartService: MockCartService(),
            productService: MockProductService(),
            orderService: mockOrderService
        )
        
        await viewModel.getOrderedProducts()
        
        #expect(viewModel.errorMessage?.contains("Falha simulada") == true)
    }
    
    @Test("Deve limpar pedidos com sucesso")
    func test_cleanOrders_success() async throws {
        let order = OrderedProduct(productId: 2, productTitle: "Produto 2", productDetails: "Detalhes", productPrice: 20.0, productThumbnail: "", productCategory: "", productShippingInformation: "", productQuantity: 1)
        let mockOrderService = MockOrderService(initialOrders: [order])
        
        let viewModel = OrderViewModel(
            cartService: MockCartService(),
            productService: MockProductService(),
            orderService: mockOrderService
        )
        
        viewModel.cleanOrders()
        
        await viewModel.getOrderedProducts()
        #expect(viewModel.orderedProducts.isEmpty)
    }
    
    @Test("Deve setar mensagem de erro ao falhar em limpar pedidos")
    func test_cleanOrders_failure() async throws {
        let mockOrderService = MockOrderService(shouldFail: true)
        
        let viewModel = OrderViewModel(
            cartService: MockCartService(),
            productService: MockProductService(),
            orderService: mockOrderService
        )
        
        viewModel.cleanOrders()
        
        #expect(viewModel.errorMessage?.contains("Falha simulada") == true)
    }
    
    @Test("Deve adicionar pedido com sucesso")
    func test_addProductOrder_success() async throws {
        let mockOrderService = MockOrderService()
        let viewModel = OrderViewModel(
            cartService: MockCartService(),
            productService: MockProductService(),
            orderService: mockOrderService
        )
        
        let newOrder = OrderedProduct(productId: 3, productTitle: "Produto 3", productDetails: "Detalhes", productPrice: 15.0, productThumbnail: "", productCategory: "", productShippingInformation: "", productQuantity: 2)
        
        try mockOrderService.addProductOrder(products: [newOrder])
        await viewModel.getOrderedProducts()
        
        #expect(viewModel.orderedProducts.contains { $0.id == newOrder.id })
    }
    
    @Test("Deve setar mensagem de erro ao falhar ao adicionar pedido")
    func test_addProductOrder_failure() async throws {
        let mockOrderService = MockOrderService(shouldFail: true)
        let viewModel = OrderViewModel(
            cartService: MockCartService(),
            productService: MockProductService(),
            orderService: mockOrderService
        )
        
        do {
            try mockOrderService.addProductOrder(products: [])
        } catch {
            viewModel.errorMessage = error.localizedDescription
        }
        
        #expect(viewModel.errorMessage?.contains("Falha simulada") == true)
    }
}
