//
//  Character.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import SwiftUI
import SwiftData


struct ProductResponse: Codable {
    var products: [Product]
}

struct Product: Identifiable, Codable {
    var id: Int
    var title: String
    var details: String
    var price: Double
    var thumbnail: String
    var category: String
    var shippingInformation: String
    
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
            case id
            case title
            case details = "description"
            case price
            case thumbnail
            case category
            case shippingInformation
    }
    
}

struct Location: Decodable {
    var name: String
    var url: String
}

struct Origin: Decodable {
    var name: String
    var url: String
}
