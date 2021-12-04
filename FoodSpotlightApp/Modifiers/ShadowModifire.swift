//
//  ShadowModifire.swift
//  FoodSpotlightApp
//
//  Created by Omar on 3.12.2021.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
    }
}
