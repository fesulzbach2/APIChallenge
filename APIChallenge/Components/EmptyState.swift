//
//  ContentView.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 13/08/25.
//

import SwiftUI

struct EmptyState: View {
    
    var icon: String = "cart.fill"
    var deliveryDate: String = "DELIVERY BY MONTH, 00"
    var name: String = "Product name with two or more lines goes here"
    var price: Double = 0.0
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            Image(systemName: icon)
                .resizable()
                .frame(width: 78, height: 78)
                .frame(alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
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

#Preview {
    EmptyState()
}
