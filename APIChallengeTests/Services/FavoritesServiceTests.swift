import Foundation
@testable import APIChallenge


class FavoritesServiceTests: FavoritesServiceProtocol {
    
    var shouldFail = false
    
    private var favoritedIDs: [FavoritedProduct]

    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
        if shouldFail {
            favoritedIDs = []
            
        } else {
            self.favoritedIDs = [FavoritedProduct(id: 1), FavoritedProduct(id: 2)]
        }
    }
    
    func fetchFavoritedProductsIDs() throws -> [FavoritedProduct] {
        if shouldFail {
            throw NSError(domain: "MockError", code: 0, userInfo: nil)
        }
        
        return favoritedIDs
    }

    func addFavoritedProduct(id: Int) {
        favoritedIDs.append(FavoritedProduct(id: id))
        print("Mock: Adicionado o produto com ID \(id)")
    }

    func removeFavoritedProduct(id: Int) {
        if let index = favoritedIDs.firstIndex(where: { $0.id == id }) {
            favoritedIDs.remove(at: index)
            print("Mock: Removido o produto com ID \(id)")
        }
        print("Mock: Não foi possível encontrar o produto com ID \(id)")
    }
    
}
