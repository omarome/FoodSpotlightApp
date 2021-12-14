//  CategoryView.swift
//  FoodSpotlightApp
//
//  Created by iosdev on 26.11.2021.
//
import SwiftUI
import L10n_swift

struct CategoryView: View {

    @Binding var selectedCategory: FoodCategory
    let category: FoodCategory

    var body: some View {
        Button(action: { selectedCategory = category }) {
            HStack {
                Text(category.emoji)
                    .font(.title)
                Text(category.name.capitalized)
                    .bold()
            }
        }
        .padding(.small)
        .padding(.horizontal, .medium)
        .background(selectedCategory == category ? Color.blue : .white)
        .cornerRadius(20)
        .foregroundColor(selectedCategory == category ? Color.white : .black)
    }
}
