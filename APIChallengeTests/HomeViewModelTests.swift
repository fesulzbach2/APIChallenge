//
//  HomeViewModelTests.swift
//  APIChallengeTests
//
//  Created by Fernando Sulzbach on 26/08/25.
//

import Testing
@testable import APIChallenge

@Suite("Testes do HomeViewModel")
struct HomeViewModelTests {
    
    @Test("Deve carregar produtos e marcar favoritos corretamente")
    func loadProducts_success() async throws {
        // Given
        var viewModel = HomeViewModel(
            productService: ProductServiceTests(shouldFail: false),
            favoriteService: FavoritesServiceTests(shouldFail: false)
        )
        
        // When
        await viewModel.loadProducts()
        
        // Then
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.products.count == 2)
        #expect(viewModel.products.filter { $0.isFavorite }.count == 2)
    }
    
    @Test("Quando ProductService falha, deve definir errorMessage e não carregar produtos")
    func loadProducts_productServiceFailure() async throws {
        // Given
        var viewModel = HomeViewModel(
            productService: ProductServiceTests(shouldFail: true),
            favoriteService: FavoritesServiceTests(shouldFail: false)
        )
        
        // When
        await viewModel.loadProducts()
        
        // Then
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.products.isEmpty)
    }
    
    @Test("Quando FavoritesService falha, deve definir errorMessage mas ainda carregar produtos")
    func loadProducts_favoritesServiceFailure() async throws {
        // Given
        var viewModel = HomeViewModel(
            productService: ProductServiceTests(shouldFail: false),
            favoriteService: FavoritesServiceTests(shouldFail: true)
        )
        
        // When
        await viewModel.loadProducts()
        
        // Then
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.products.count == 2)
        #expect(viewModel.products.filter { $0.isFavorite }.isEmpty) // não conseguiu marcar favoritos
    }
    
    @Test("updateFavorites deve marcar produtos favoritos corretamente")
    func updateFavorites_marksFavorites() async throws {
        // Given
        var viewModel = HomeViewModel(
            productService: ProductServiceTests(shouldFail: false),
            favoriteService: FavoritesServiceTests(shouldFail: false)
        )
        
        await viewModel.loadProducts()
        
        // Then
        #expect(viewModel.products.filter { $0.isFavorite }.count == 2)
    }
    
    @Test("toggleFavorite deve adicionar e remover favoritos corretamente")
    func toggleFavorite_addAndRemove() async throws {
        // Given
        var viewModel = HomeViewModel(
            productService: ProductServiceTests(shouldFail: false),
            favoriteService: FavoritesServiceTests(shouldFail: false)
        )
        await viewModel.loadProducts()
        
        var product = viewModel.products[0]
        
        // When - remover
        await viewModel.toggleFavorite(product: product)
        await viewModel.loadFavoritedProducts()
        #expect(viewModel.favoritedProducts.contains(where: { $0.id == product.id }) == false)
        
        // When - adicionar de novo
        await viewModel.toggleFavorite(product: product) 
        await viewModel.loadFavoritedProducts()
        #expect(viewModel.favoritedProducts.contains(where: { $0.id == product.id }) == true)
    }
}
