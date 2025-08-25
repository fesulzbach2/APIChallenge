//
//  StoredProduct 2.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 15/08/25.
//

import SwiftUI
import SwiftData

@Model
final class FavoritedProduct {
    var id: Int

    init(id: Int) {
        self.id = id
    }
}
