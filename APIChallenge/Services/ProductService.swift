//
//  CharacterService.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import Foundation

class ProductService: ProductServiceProtocol {
    
    private let baseURL = "https://dummyjson.com"
    
    // MARK: Function to fetch x4only one character based on number
    func fetchProduct(number: Int) async throws -> Product {
        let urlString: String = "\(baseURL)/product/\(number)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // MARK: Example Using the HTTP Response
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let productResponse = try JSONDecoder().decode(Product.self, from: data)
        
        return productResponse
    }
    
    // MARK: Function to fetch all characters
    func fetchProducts() async throws -> [Product] {
        let urlString: String = "\(baseURL)/products"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ProductResponse.self, from: data)
        
        print(response.products)
        
        return response.products
    }
    
    func fetchProducts(for ids: [Int]) async throws -> [Product] {
        try await withThrowingTaskGroup(of: Product.self) { group in
            
            for id in ids {
                group.addTask {
                    try await self.fetchProduct(number: id)
                }
            }
            
            var products: [Product] = []
            for try await product in group {
                products.append(product)
            }
            
            return products
        }
    }
}
