//
//  ProductViewModelTests.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 26/08/25.
//


import Testing
@testable import APIChallenge

struct ProductViewModelTests {

    @Test("Deve carregar todos os produtos com sucesso")
    func test_loadProducts_success() async throws {
        let mockService = MockProductService(shouldFail: false)
        let viewModel = ProductViewModel(service: mockService)
        
        await viewModel.loadProducts()
        
        #expect(viewModel.products.count == mockService.mockProducts.count)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
    }

    @Test("Deve definir mensagem de erro ao falhar ao carregar produtos")
    func test_loadProducts_failure() async throws {
        let mockService = MockProductService(shouldFail: true)
        let viewModel = ProductViewModel(service: mockService)
        
        await viewModel.loadProducts()
        
        #expect(viewModel.products.isEmpty)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage?.contains("Falha simulada") == true)
    }

    @Test("Deve carregar produto específico com sucesso")
    func test_loadProduct_success() async throws {
        let mockService = MockProductService(shouldFail: false)
        let viewModel = ProductViewModel(service: mockService)
        
        await viewModel.loadProduct(id: 1)
        
        #expect(viewModel.product?.id == 1)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
    }

    @Test("Deve definir mensagem de erro ao falhar ao carregar produto específico")
    func test_loadProduct_failure() async throws {
        let mockService = MockProductService(shouldFail: true)
        let viewModel = ProductViewModel(service: mockService)
        
        await viewModel.loadProduct(id: 1)
        
        #expect(viewModel.product == nil)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage?.contains("Falha simulada") == true)
    }
}
