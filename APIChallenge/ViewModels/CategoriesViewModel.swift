//
//  FavoritesViewModel.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 20/08/25.
//


import Foundation
import SwiftData

@Observable
class CategoriesViewModel: ObservableObject {
    
    var searchText: String = ""
    
    var filteredCategories: [Category] {
        searchText.isEmpty
            ? Category.allCases
            : Category.allCases.filter {
            $0.rawValue.localizedCaseInsensitiveContains(searchText)
        }
    }
        
}
