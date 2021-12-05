//
//  FoodCategories.swift
//  FoodSpotlightApp
//
//  Created by iosdev on 26.11.2021.
//

import Foundation

enum FoodCategory: String, CaseIterable, Equatable {
    case all, coffee, pizza, burger, sushi, tacos

    var emoji: String {
        switch self {
        case .all:
            return "\u{1F959}"
        case .coffee:
            return "\u{2615}"
        case .pizza:
            return "\u{1F355}"
        case .burger:
            return "\u{1F354}"
        case .sushi:
            return "\u{1F363}"
        case .tacos:
            return "\u{1F32E}"
        }
    }

    var alias: String {
        switch self {
        case .all:
            return "restaurants"
        case .coffee:
            return "coffee"
        case .pizza:
            return "pizza"
        case .burger:
            return "burger"
        case .sushi:
            return "sushi"
        case .tacos:
            return "taco"
        }
    }
}
