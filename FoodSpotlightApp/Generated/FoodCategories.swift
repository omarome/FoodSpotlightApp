//
//  FoodCategories.swift
//  FoodSpotlightApp
//
//  Created by iosdev on 26.11.2021.
//
import L10n_swift
import Foundation

enum FoodCategory: String, CaseIterable, Equatable {
    case all, coffee, italian, pizza, burgers, sushi, british, chinese

    var emoji: String {
        switch self {
        case .all:
            return "\u{1F37D}"
        case .coffee:
            return "\u{2615}"
        case .pizza:
            return "\u{1F355}"
        case .burgers:
            return "\u{1F354}"
        case .sushi:
            return "\u{1F363}"
        case .chinese:
            return "\u{1F961}"
        case .british:
            return "\u{1F373}"
        case .italian:
            return "\u{1F35D}"
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
        case .burgers:
            return "burgers"
        case .sushi:
            return "sushi"
        case .chinese:
            return "chinese"
        case .british:
            return "british"
        case .italian:
            return "italian"
        }
    }
    
    var name: String {
        switch self {
        case .all:
            return L10n.all
        case .coffee:
            return L10n.coffee
        case .pizza:
            return L10n.pizza
        case .burgers:
            return L10n.burgers
        case .sushi:
            return L10n.sushi
        case .chinese:
            return L10n.chinese
        case .british:
            return L10n.british
        case .italian:
            return L10n.italian
        }
    }
}
