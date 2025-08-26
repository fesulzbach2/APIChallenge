//
//  CategoriesViewModelTests.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 26/08/25.
//


import Testing
@testable import APIChallenge

struct CategoriesViewModelTests {

    @Test("Filtragem deve retornar todas as categorias quando searchText está vazio")
    func test_filteredCategories_emptySearch() {
        let viewModel = CategoriesViewModel()
        viewModel.searchText = ""
        
        #expect(viewModel.filteredCategories.count == Category.allCases.count)
    }

    @Test("Filtragem deve retornar apenas categorias que correspondem ao searchText")
    func test_filteredCategories_withSearch() {
        let viewModel = CategoriesViewModel()
        viewModel.searchText = "beau" 
        
        let filtered = viewModel.filteredCategories
        
        #expect(filtered.allSatisfy { $0.rawValue.localizedCaseInsensitiveContains("beau") })
    }

    @Test("Filtragem deve ser case insensitive")
    func test_filteredCategories_caseInsensitive() {
        let viewModel = CategoriesViewModel()
        viewModel.searchText = "BEAUTY"
        
        let filtered = viewModel.filteredCategories
        
        #expect(filtered.allSatisfy { $0.rawValue.localizedCaseInsensitiveContains("BEAUTY") })
    }

    @Test("Filtragem deve retornar vazio se nenhuma categoria corresponder")
    func test_filteredCategories_noMatch() {
        let viewModel = CategoriesViewModel()
        viewModel.searchText = "xyz"
        
        #expect(viewModel.filteredCategories.isEmpty)
    }
}
