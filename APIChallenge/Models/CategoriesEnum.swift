import SwiftUI

enum Category: String, CaseIterable, Codable {
    case Beauty = "Beauty"
    case Fragrances = "Fragrances"
    case Furniture = "Furniture"
    case Groceries = "Groceries"
    case HomeDecoration = "Home Decoration"
    case KitchenAccessories = "Kitchen Accessories"
    case Laptop = "Laptop"
    case MensShirts = "Mens Shirts"
    case MensShoes = "Mens Shoes"
    case MensWatches = "Mens Watches"
    case MobileAccessories = "Mobile Accessories"
    case Motorcycle = "Motorcycle"
    case SkinCare = "Skin Care"
    case Smartphones = "Smartphones"
    case SportsAccessories = "Sports Accessories"
    case Sunglasses = "Sunglasses"
    case Tablets = "Tablets"
    case Tops = "Tops"
    case Vehicle = "Vehicle"
    case WomensBags = "Womens Bags"
    case WomensDresses = "Womens Dresses"
    case WomensJewellery = "Womens Jewellery"
    case WomensShoes = "Womens Shoes"
    case WomensWatches = "Womens Watches"
    
    var id: String { rawValue }
    
    var image: Image {
        switch self {
        case .Beauty: return Image("Beauty")
        case .Fragrances: return Image("Fragrances")
        case .Furniture: return Image("Furniture")
        case .Groceries: return Image("Groceries")
        case .HomeDecoration: return Image("HomeDecoration")
        case .KitchenAccessories: return Image("KitchenAccessories")
        case .Laptop: return Image("Laptop")
        case .MensShirts: return Image("MensShirts")
        case .MensShoes: return Image("MensShoes")
        case .MensWatches: return Image("MensWatches")
        case .MobileAccessories: return Image("MobileAccessories")
        case .Motorcycle: return Image("Motorcycle")
        case .SkinCare: return Image("SkinCare")
        case .Smartphones: return Image("Smartphones")
        case .SportsAccessories: return Image("SportsAccessories")
        case .Sunglasses: return Image("Sunglasses")
        case .Tablets: return Image("Tablets")
        case .Tops: return Image("Tops")
        case .Vehicle: return Image("Vehicle")
        case .WomensBags: return Image("WomensBags")
        case .WomensDresses: return Image("WomensDresses")
        case .WomensJewellery: return Image("WomensJewellery")
        case .WomensShoes: return Image("WomensShoes")
        case .WomensWatches: return Image("WomensWatches")
        }
    }
}
