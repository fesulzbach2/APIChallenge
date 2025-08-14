//
//  Character.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

struct ProductResponse: Decodable {
    var products: [Product]
}

struct Product: Identifiable, Decodable {
    var id: Int
    var title: String
    var price: Double
    var thumbnail: String
}

struct Location: Decodable {
    var name: String
    var url: String
}

struct Origin: Decodable {
    var name: String
    var url: String
}
