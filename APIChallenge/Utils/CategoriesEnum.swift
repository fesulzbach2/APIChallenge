//
//  CategoriesEnum.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 13/08/25.
//

import SwiftUI

enum Categories: String, CaseIterable {
    case Beauty = "Beauty"
    case Fragrance = "Fragrance"
    case Furniture = "Furniture"
    case Groceries = "Groceries"
    case HomeDecoration = "Home Decoration"
    case KitchenAccessories = "Kitchen Accessories"
    case Laptop = "Laptop"
    case MensShirts = "Mens Shirts"
    case MensShoes = "Mens Shoes"
    
    var image: Image {
        switch self {
        case .Beauty:
            return Image("Beauty")
        case .Fragrance:
            return Image("Fragrance")
        case .Furniture:
            return Image("Furniture")
        case .Groceries:
            return Image("Groceries")
        case .HomeDecoration:
            return Image("HomeDecoration")
        case .KitchenAccessories:
            return Image("KitchenAccessories")
        case .Laptop:
            return Image("Laptop")
        case .MensShirts:
            return Image("MensShirts")
        case .MensShoes:
            return Image("MensShoes")
        }
    }
}
