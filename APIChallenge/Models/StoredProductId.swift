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
final class StoredProductID {
    @Attribute(.unique) var id: Int
    var isFavorite: Bool = false

    init(id: Int, isFavorite: Bool) {
        self.id = id
        self.isFavorite = isFavorite
    }
    
}
