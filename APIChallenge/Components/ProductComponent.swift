//
//  CharacterComponent.swift
//  APIService
//
//  Created by Eduardo Pasqualotto Riboli on 05/08/25.
//

import SwiftUI

struct ProductComponent: View {
    
    var product: Product
    
    var body: some View {
        HStack {
            
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                            image.resizable()
                        } placeholder: {
                            Image(systemName: "photo")
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(.gray.opacity(0.3))
                                        .frame(width: 50, height: 50)
                                )
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())

            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.callout)
                    .fontWeight(.semibold)

                Text(product.price.description)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Text(product.id.description)
                .font(.callout)
        }
    }
}

//#Preview {
//    CharacterComponent(character: .init(id: 2, name: "Rick And Morty", status: "Status", species: "Species", gender: "Gender", origin: .init(name: "", url: ""), location: .init(name: "", url: ""), image: ""))
//}
