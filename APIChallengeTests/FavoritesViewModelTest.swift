import Testing
@testable import APIChallenge


@Suite("Testes do FavoritesViewModel")
struct FavoritesViewModelTests {
    
    @Test func test_fetchProductsSucess() async throws {
            
            // Given
            var viewModel = FavoritesViewModel(productService: ProductServiceTests(shouldFail: false), favoriteService: FavoritesServiceTests(shouldFail: false))
        
            var productService = ProductServiceTests(shouldFail: false)
            var favoriteService = FavoritesServiceTests(shouldFail: false)
            
            // When
            await viewModel.loadProducts()
            
            
            // Then
            #expect(!viewModel.products.isEmpty)
            #expect(viewModel.errorMessage == nil)
            #expect(viewModel.isLoading == false)
            #expect(viewModel.products.count == 2)
        }



    // MARK: - Testes para loadProducts()
    @Test("Ao carregar sem nenhum favorito, a lista de produtos deve ficar vazia")
    func loadProducts_noFavorites() async throws {
        
        // Given
        var viewModel = FavoritesViewModel(productService: ProductServiceTests(shouldFail: true), favoriteService: FavoritesServiceTests(shouldFail: true))
        
        // Then
        await viewModel.loadProducts()

        // When
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.products.isEmpty)
    }

    @Test("Quando o serviço de produtos falha, uma mensagem de erro deve ser definida")
    func loadProducts_productServiceFailure() async throws {
        
        // Given
        var viewModel = FavoritesViewModel(productService: ProductServiceTests(shouldFail: true), favoriteService: FavoritesServiceTests(shouldFail: false))
    
        var productService = ProductServiceTests(shouldFail: true)
        var favoriteService = FavoritesServiceTests(shouldFail: false)
        
        // When
        await viewModel.loadProducts()

        // Then
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.products.isEmpty)
        

        let hasExpectedError = viewModel.errorMessage?.contains("Falha simulada na busca de produtos") ?? false
        #expect(hasExpectedError)
    }

    // MARK: - Testes para a Lógica de Filtro
    @Test("Ao usar o campo de busca, a lista de favoritos deve ser filtrada corretamente")
    func filteredFavorites_withSearchText() {
        
        // Given
        var viewModel = FavoritesViewModel(productService: ProductServiceTests(shouldFail: true), favoriteService: FavoritesServiceTests(shouldFail: false))
        
        viewModel.products = [
            Product (id: 1, title: "Luva de Lã", details: "This Product is a product", price: 10.50, thumbnail: "thumbnail mock", category: "Beauty", shippingInformation: "Ships in 2-3 days"),
            Product (id: 1, title: "Casaco de Couro", details: "This Product is a product", price: 10.50, thumbnail: "thumbnail mock", category: "Beauty", shippingInformation: "Ships in 2-3 days"),
            Product (id: 1, title: "Cachecol de Lã", details: "This Product is a product", price: 10.50, thumbnail: "thumbnail mock", category: "Beauty", shippingInformation: "Ships in 2-3 days"),
        ]
        
        
        // When
        viewModel.searchText = "Lã"
        // Then
        #expect(viewModel.filteredFavorites.count == 2)
        
        //When
        viewModel.searchText = "Couro"
        // Then
        #expect(viewModel.filteredFavorites.count == 1)
        #expect(viewModel.filteredFavorites.first?.title == "Casaco de Couro")

        // When
        viewModel.searchText = ""
        // Then
        #expect(viewModel.filteredFavorites.count == 3)
    }
}
