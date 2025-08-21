//
//  MockProductsTests.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 20/08/25.
//
//import Foundation
//@testable import APIChallenge
//
//class MockProductsTests: ProductServiceProtocol {
//    var shouldFail: Bool = false
//    private var product: Product
//    
//    init(shouldFail: Bool = false) {
//        self.shouldFail = shouldFail
//        self.character = Character(id: 0, name: "", status: "", species: "", gender: "", origin: Origin(name: "", url: ""), location: Location(name: "", url: ""), image: "")
//    }
//    
//    
//    func fetchProduct(number: Int) async throws -> APIService.Character  {
//        if shouldFail {
//            throw NSError(domain: #function, code: 1)
//        } else {
//            return character
//        }
//    }
//    
//    func fetchProducts() async throws -> APIService.Character  {
//        if shouldFail {
//            throw NSError(domain: #function, code: 1)
//        } else {
//            return character
//        }
//    }
//}
