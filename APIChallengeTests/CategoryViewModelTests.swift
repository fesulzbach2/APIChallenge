import Testing
@testable import APIChallenge

struct CategoryViewModelTests {

    @Test("Ao carregar produtos, deve popular productsByCategory e produtos favoritos")
    func test_loadProducts_success() async throws {
        let mockProductService = MockProductService(shouldFail: false)
        let mockFavoritesService = MockFavoritesService(shouldFail: false)
        
        let viewModel = CategoryViewModel(
            productService: mockProductService,
            favoriteService: mockFavoritesService
        )
        
        await viewModel.loadProducts(category: .Beauty)
        
        #expect(viewModel.isLoading == false)
        #expect(viewModel.products.isEmpty == false)
        #expect(viewModel.productsByCategory.allSatisfy { $0.category.lowercased() == Category.Beauty.rawValue.lowercased() })
        #expect(viewModel.errorMessage == nil)
    }

    @Test("Ao falhar ao carregar produtos, deve setar errorMessage")
    func test_loadProducts_failure() async throws {
        let mockProductService = MockProductService(shouldFail: true)
        let mockFavoritesService = MockFavoritesService()
        
        let viewModel = CategoryViewModel(
            productService: mockProductService,
            favoriteService: mockFavoritesService
        )
        
        await viewModel.loadProducts(category: .Beauty)
        
        #expect(viewModel.isLoading == false)
        #expect(viewModel.products.isEmpty)
        #expect(viewModel.errorMessage?.contains("Falha simulada") == true)
    }

    @Test("Filtragem por searchText deve funcionar corretamente")
    func test_filteredProducts_withSearchText() async throws {
        let mockProductService = MockProductService(shouldFail: false)
        let mockFavoritesService = MockFavoritesService()
        
        let viewModel = CategoryViewModel(
            productService: mockProductService,
            favoriteService: mockFavoritesService
        )
        
        await viewModel.loadProducts(category: .Beauty)
        
        viewModel.searchText = "Product 1"
        #expect(viewModel.filteredProducts.count == 1)
        #expect(viewModel.filteredProducts.first?.title == "Product 1")
        
        viewModel.searchText = ""
        #expect(viewModel.filteredProducts.count == viewModel.productsByCategory.count)
    }

    @Test("toggleFavorite deve adicionar e remover corretamente")
    func test_toggleFavorite() async throws {
        let mockFavoritesService = MockFavoritesService()
        let mockProductService = MockProductService(shouldFail: false)
        
        let viewModel = CategoryViewModel(
            productService: mockProductService,
            favoriteService: mockFavoritesService
        )
        
        let product = Product(id: 99, title: "X", details: "d", price: 1.0,
                              thumbnail: "t", category: "Beauty", shippingInformation: "s", isFavorite: false)
        
        viewModel.toggleFavorite(product: product)
        #expect(try mockFavoritesService.fetchFavoritedProductsIDs().contains { $0.id == 99 })
        
        let favoritedProduct = Product(id: 1, title: "Y", details: "d", price: 1.0,
                                       thumbnail: "t", category: "Beauty", shippingInformation: "s", isFavorite: true)
        viewModel.toggleFavorite(product: favoritedProduct)
        #expect(!(try mockFavoritesService.fetchFavoritedProductsIDs().contains { $0.id == 1 }))
    }
    
    @Test("filterProductsByCategory deve filtrar corretamente")
    func test_filterProductsByCategory() async throws {
        let mockProductService = MockProductService(shouldFail: false)
        let mockFavoritesService = MockFavoritesService()
        
        let viewModel = CategoryViewModel(
            productService: mockProductService,
            favoriteService: mockFavoritesService
        )
        
        await viewModel.loadProducts(category: .Beauty)
        viewModel.filterProductsByCategory(category: .Beauty)
        
        #expect(viewModel.productsByCategory.allSatisfy { $0.category.lowercased() == Category.Beauty.rawValue.lowercased() })
    }
}
