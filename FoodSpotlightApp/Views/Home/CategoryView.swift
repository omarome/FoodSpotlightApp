//
//  CategoryView.swift
//  FoodSpotlightApp
//
//  Created by Omar on 1.12.2021.
//

import SwiftUI

struct CategoryView: View {

    @Binding var selectedCategory: FoodCategory
    let category: FoodCategory

    var body: some View {
        Button(action: { selectedCategory = category }) {
            HStack {
                Text(category.emoji)
                    .font(.title)
                Text(category.rawValue.capitalized)
                
            }
        }
        .padding(4)
        .padding(.horizontal, 8)
        .background(selectedCategory == category ? Color.red : .white)
        .cornerRadius(20)
        .padding(.top, 4)
        .padding(.bottom, 16)
        .modifier(ShadowModifier())
        .foregroundColor(.black)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(selectedCategory: .constant(.coffee), category: .coffee)
    }
}

/*
import SwiftUI

struct CategoryView: View {

    @Binding var selectedCategory: FoodCategory
    let category: FoodCategory

    var body: some View {
        Button(action: { selectedCategory = category }) {
            HStack {
                Text(category.emoji)
                    .font(.title)
                Text(category.rawValue.capitalized)
                    .bold()
            }
        }
        .padding(4)
        .padding(.horizontal, 8)
        .background(selectedCategory == category ? Color.red : .white)
        .cornerRadius(20)
        .foregroundColor(.black)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(selectedCategory: .constant(.coffee), category: .coffee)
    }
}
*/
