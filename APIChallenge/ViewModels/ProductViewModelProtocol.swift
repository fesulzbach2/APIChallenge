//
//  UserViewModelProtocol.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import Foundation

protocol ProductViewModelProtocol {
    var product: Product? { get }
    var products: [Product] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadProducts() async
}
