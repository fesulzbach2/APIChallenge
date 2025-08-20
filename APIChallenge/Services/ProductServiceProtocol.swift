//
//  CharacterServiceProtocol.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

protocol ProductServiceProtocol {
    func fetchProduct(number: Int) async throws -> Product
    func fetchProducts() async throws -> [Product]
    func fetchProducts(for ids: [Int]) async throws -> [Product]
}
