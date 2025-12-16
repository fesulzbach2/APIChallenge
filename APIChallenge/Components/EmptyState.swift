//
//  ContentView.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 13/08/25.
//

import SwiftUI

struct EmptyState: View {
    
    var icon: String = "cart.badge.questionmark"
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            Image(systemName: icon)
                .font(.system(size:48))
                .frame(width: 65, height: 69)
                .foregroundStyle(.gray2)
            
            VStack(spacing: 16) {
                Text("Your cart is empty!")
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
                
                Text("Add an item to your cart.")
                    .fontWeight(.regular)
                    .font(.system(size: 17))
                    .foregroundStyle(.labelsSecondary)
            }
            
        }
        
    }
}

#Preview {
    EmptyState()
}
