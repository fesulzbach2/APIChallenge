//
//  Character.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 04/08/25.
//

import SwiftUI

struct ProductResponse: Decodable {
    var products: [Product]
}

struct Product: Identifiable, Decodable {
    var id: Int
    var title: String
    var description: String
    var price: Double
    var thumbnail: String
    var category: String
    var shippingInformation: String
    
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
            case id
            case title
            case description
            case price
            case thumbnail
            case category
            case shippingInformation
    }
    
//    func categoryImage() -> Image {
//        
//        if let categoryType = Category(rawValue: category) {
//            
//            return categoryType.image
//        }
//        return Category.Beauty.image
//    }
    
}

struct Location: Decodable {
    var name: String
    var url: String
}

struct Origin: Decodable {
    var name: String
    var url: String
}
