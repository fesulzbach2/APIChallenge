//
//  ContentView.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 13/08/25.
//

import SwiftUI

struct ProductCart: View {
    
    var category: Category? {
        Category(rawValue: product.category)
    }
    //    var price: Double = 0.0
    var product: Product
    
    @State var quantity: Int = 1
    
//    var cartViewModel: CartViewModel = CartViewModel(cartService: CartService(), productService: ProductService())
//
    
    var increaseQuantity: ()->Void
    var decreaseQuantity: ()->Void
    
    
    var body: some View {
        
        HStack(spacing: 16) {
            //            if let category {
            //                category.image
            //                    .resizable()
            //                    .frame(width: 78, height: 78)
            //                    .clipShape(RoundedRectangle(cornerRadius: 12))
            //                    .frame(alignment: .leading)
            //            } else {
            //
            //            }
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 78, height: 78)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                let category = Category(rawValue: product.category)
                category?.image
                    .resizable()
                    .frame(width: 78, height: 78)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .frame(alignment: .leading)
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            HStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text(product.title)
                        .fontWeight(.regular)
                        .font(.system(size: 13))
                        .frame(height: 36)
                    
                    
                    Text("US$\(product.price.formatted(.number.precision(.fractionLength(2))))")
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 62)
                
                HStack(spacing: 0.5) {
                    
                    Button {
                        
                        if quantity > 0 {
                            quantity -= 1
                            decreaseQuantity()
                        }
                        
                    } label: {
                        
                        Image(systemName: "minus")
                            .foregroundStyle(.labelsPrimary)
                            .font(.system(size: 12))
                            .padding(.all, 4)
                            .frame(width: 23, height: 23)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.fillsTertiary)
                            )
                            .foregroundStyle(.labelsPrimary)
                    }
                    
                    Text(quantity.description)
                        .fontWeight(.regular)
                        .font(.system(size: 17))
                        .frame(width: 25)
                    //  .frame(width: 16, height: 22, alignment: .center)
                    
                    Button {
                        quantity += 1
//                        let cartProductAux = CartProduct(id: product.id, product: product, quantity: quantity)
//                        cartViewModel.increaseQuantity(for: cartProductAux)
                        increaseQuantity()
                        
                    } label: {
                        
                        Image(systemName: "plus")
                            .foregroundStyle(.labelsPrimary)
                            .font(.system(size: 12))
                            .padding(.all, 4)
                            .frame(width: 23, height: 23)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.fillsTertiary)
                            )
                            .foregroundStyle(.labelsPrimary)
                    }
                    
                    
                    
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.leading, 8)
        .padding(.trailing, 16)
        .frame(maxWidth: .infinity)
        .frame(height: 94)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundsSecondary)
        )
    }
}

//#Preview {
//    ProductCart(product: Product(id: 19, title: "teste", description: "aaa", price: 7.00, thumbnail: "a", category: Category.Beauty.rawValue, shippingInformation: "a"))
//}
