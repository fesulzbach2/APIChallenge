//
//  StoredProduct 2.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 15/08/25.
//


//
//  ProductFavorites.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 15/08/25.
//
//

import SwiftUI
import SwiftData

@Model
final class CartProduct {
    @Attribute(.unique) var id: Int
    var quantity: Int

    init(id: Int, quantity: Int) {
        self.id = id
        self.quantity = 1
    }
    
}


