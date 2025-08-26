//
//  DetailsViewModelTests.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 26/08/25.
//

import Testing
@testable import APIChallenge

struct DetailsViewModelTests {
    
    @Test("Deve adicionar produto aos favoritos quando não favorito")
    func test_toggleFavorite_addsWhenNotFavorite() async throws {
        let mockFavoritesService = MockFavoritesService()
        
        let modelView = DetailsViewModel(
            productService: MockProductService(),
            favoriteService: mockFavoritesService, // usar a MESMA instância
            cartService: MockCartService()
        )
        
        let product = Product(
            id: 99, title: "X", details: "d", price: 1.0,
            thumbnail: "t", category: "c", shippingInformation: "s",
            isFavorite: false
        )
        
        await modelView.toggleFavorite(product: product)
        
        #expect(try mockFavoritesService.fetchFavoritedProductsIDs().contains { $0.id == 99 })
    }

    
    @Test("Deve remover produto dos favoritos quando já é favorito")
    func test_toggleFavorite_removesWhenFavorite() async throws {
        let mockFavoritesService = MockFavoritesService()
        
        let modelView = DetailsViewModel(
            productService: MockProductService(),
            favoriteService: MockFavoritesService(),
            cartService: MockCartService()
        )
        
        let product = Product(
            id: 1, title: "Y", details: "d", price: 1.0,
            thumbnail: "t", category: "c", shippingInformation: "s",
            isFavorite: true
        )
        
        await modelView.toggleFavorite(product: product)
        
        #expect(try mockFavoritesService.fetchFavoritedProductsIDs().contains { $0.id == 1 })
    }
    
    @Test("Deve adicionar item ao carrinho com sucesso")
    func test_addToCart_success() throws {
        let mockCartService = MockCartService()
        let modelView = DetailsViewModel(
            productService: MockProductService(),
            favoriteService: MockFavoritesService(),
            cartService: mockCartService
        )
        
        modelView.addToCart(productId: 5)
        
        let cart = try mockCartService.getCartProductIds()
        #expect(cart.first?.productId == 5)
        #expect(modelView.errorMessage == nil)
    }
    
    @Test("Deve definir mensagem de erro ao falhar no carrinho")
    func test_addToCart_failure_setsErrorMessage() throws {
        
        let modelView = DetailsViewModel(
            productService: MockProductService(shouldFail: false),
            favoriteService: MockFavoritesService(shouldFail: false),
            cartService: MockCartService(shouldFail: true)
        )
        
        modelView.addToCart(productId: 7)
        
        #expect(modelView.errorMessage?.contains("Falha simulada") == true)
    }
}
