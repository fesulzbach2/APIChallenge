//
//  ContentView.swift
//  APIChallenge
//
//  Created by Fernando Sulzbach on 13/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            MediumCard(isHorizontal: false, category: .HomeDecoration, text: "Product name with two or more lines goes here", price: 0.0)
            Spacer()
            MediumCard(isHorizontal: false, category: .HomeDecoration, text: "Product name ", price: 0.0)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    ContentView()
}
