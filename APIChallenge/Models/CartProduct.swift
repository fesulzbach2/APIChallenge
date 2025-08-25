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

struct CartProduct: Identifiable {
    var id: Int
    var product: Product
    var quantity: Int

    init(id: Int, product: Product, quantity: Int) {
        self.id = id
        self.product = product
        self.quantity = 1
    }
}
