//
//  BusinessDataModel.swift
//  FoodSpotlightApp
//
//  Created by Omar on 30.11.2021.
//

import Foundation

struct BusinessesModel: Decodable, Hashable {
    var businesses: [Business]
}

// MARK: - Business
struct Business: Codable, Hashable {
    let rating: Double?
    let price, phone, id, alias: String?
    let isClosed: Bool?
    let categories: [Category]?
    let reviewCount: Double?
    let name: String?
    let url: String?
    let coordinates: Coordinates?
    let imageURL: String?
    let location: Location?
    let distance: Double?
    let transactions: [String]?

    enum CodingKeys: String, CodingKey {
        case rating, price, phone, id, alias
        case isClosed = "is_closed"
        case categories
        case reviewCount = "review_count"
        case name, url, coordinates
        case imageURL = "image_url"
        case location, distance, transactions
    }
}

// MARK: - Category
struct Category: Codable, Hashable  {
    let alias, title: String?
}

// MARK: - Coordinates
struct Coordinates: Codable ,Hashable {
    let latitude, longitude: Double?
}

// MARK: - Location
struct Location: Codable, Hashable  {
    let city, country, address2, address3: String?
    let state, address1, zipCode: String?

    enum CodingKeys: String, CodingKey {
        case city, country, address2, address3, state, address1
        case zipCode = "zip_code"
    }
}

