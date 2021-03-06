//
//  YlepApiService.swift
//  FoodSpotlightApp
//
//  Created by Omar on 25.11.2021.
//

import Foundation
import CoreLocation
import Combine



struct YelpApiService {
    // search term, user location, category      // output to update list
    var request: (Endpoint) -> AnyPublisher<[Business], Never>
    var details: (Endpoint) -> AnyPublisher<Business?, Never>
    var completion: (Endpoint) -> AnyPublisher<[Term], Never>
}

extension YelpApiService {
    static let live = YelpApiService(
        request: { endpoint in
            // URL request and return [Businesses]
            return URLSession.shared.dataTaskPublisher(for: endpoint.request)
                .map(\.data)
                .decode(type: SearchResult.self, decoder: JSONDecoder())
                .map(\.businesses)
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        },
        details: { endpoint in
            // URL request and return Businesses
            return URLSession.shared.dataTaskPublisher(for: endpoint.request)
                .map(\.data)
                .decode(type: Business?.self, decoder: JSONDecoder())
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .print("yo11")
                .eraseToAnyPublisher()
        }
    ) { endpoint in
        // URL request and return completions
        return URLSession.shared.dataTaskPublisher(for: endpoint.request)
            .map(\.data)
            .decode(type: Completions.self, decoder: JSONDecoder())
            .map(\.terms)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
// the URL endPoint cases
enum Endpoint {
    case search(term: String?, location: CLLocation, category: FoodCategory?)
    case detail(id: String)
    case completion(text: String, location: CLLocation)

    var path: String {
        switch self {
        case .search:
            return APIConstants().APISearch
        case .detail(let id):
            return "\(APIConstants().APIDetails)\(id)"
        case .completion:
            return APIConstants().APIComplation
        }
    }
// the url query items with switch cases
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let term, let location, let category):
            return [
                .init(name: "term", value: term),
                .init(name: "longitude", value: String(location.coordinate.longitude)),
                .init(name: "latitude", value: String(location.coordinate.latitude)),
                .init(name: "categories", value: category?.rawValue ?? FoodCategory.all.rawValue),
            ]
        case .completion(let text, let location):
            return [
                .init(name: "text", value: text),
                .init(name: "longitude", value: String(location.coordinate.longitude)),
                .init(name: "latitude", value: String(location.coordinate.latitude)),
            ]
        case .detail:
            return []
        }
    }
//make the url request and authorization with api key through token
    var request: URLRequest {
        var urlComponents = URLComponents(string: APIConstants().APIBase)!
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(APIConstants().apiKey)", forHTTPHeaderField: "Authorization")
        return request
    }

}

// MARK: - Completions
struct Completions: Codable {
    let terms: [Term]
    let businesses: [Business]
    let categories: [Category]
}

// MARK: - Term
struct Term: Codable {
    let text: String
}

// MARK: - SearchResult

struct SearchResult: Codable {
    let businesses: [Business]
}

// MARK: - Business
struct Business: Codable {
    let id, alias, name: String?
    let imageURL: String?
    let isClaimed, isClosed: Bool?
    let url: String?
    let phone, displayPhone: String?
    let reviewCount: Int?
    let categories: [Category]?
    let rating: Double?
    let location: Location?
    let coordinates: Coordinates?
    let photos: [String]?
    let price: String?
    let hours: [Hour]?
    let transactions: [String]?
    let specialHours: [SpecialHour]?

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClaimed = "is_claimed"
        case isClosed = "is_closed"
        case url, phone
        case displayPhone = "display_phone"
        case reviewCount = "review_count"
        case categories, rating, location, coordinates, photos, price, hours, transactions
        case specialHours = "special_hours"
    }
}

// MARK: - Category
struct Category: Codable {
    let alias, title: String?
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double?
}

// MARK: - Hour
struct Hour: Codable {
    let hourOpen: [Open]?
    let hoursType: String?
    let isOpenNow: Bool?

    enum CodingKeys: String, CodingKey {
        case hourOpen = "open"
        case hoursType = "hours_type"
        case isOpenNow = "is_open_now"
    }
}

// MARK: - Open
struct Open: Codable {
    let isOvernight: Bool?
    let start, end: String?
    let day: Int?

    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start, end, day
    }
}

// MARK: - Location
struct Location: Codable {
    let address1, address2, address3, city: String?
    let zipCode, country, state: String?
    let displayAddress: [String]?
    let crossStreets: String?

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
        case crossStreets = "cross_streets"
    }
}

// MARK: - SpecialHour
struct SpecialHour: Codable {
    let date: String?
    let isClosed: Bool?
    let start, end: String?
    let isOvernight: Bool?

    enum CodingKeys: String, CodingKey {
        case date
        case isClosed = "is_closed"
        case start, end
        case isOvernight = "is_overnight"
    }
}

struct MapItem: Identifiable {
    let id: UUID = .init()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

extension Business {

    var mapItems: [MapItem] {
        if let name = name, let lat = coordinates?.latitude, let long = coordinates?.longitude {
            return [MapItem(name: name, coordinate: .init(latitude: lat, longitude: long))]
        }
        return []
    }

    var formattedRating: String {
        String(format: "%.1f", rating ?? 0.0)
    }

    var formattedCategory: String {
        categories?.first?.title ?? "none"
    }

    var formattedCategories: String {
        categories?
            .lazy
            .compactMap(\.title)
            .reduce("", { $0 + "\($1) ??? " })
            .dropLast()
            .dropLast()
            .reduce("", { $0 + String($1) })
            ?? "None"
    }

    var formattedName: String {
        name ?? "none"
    }

    var formattedPhoneNumber: String {
        displayPhone ?? "none"
    }

    var formattedPrice: String {
        price ?? "none"
    }

    var formattedAddress: String {
        location?.displayAddress?.first ?? "none"
    }

    var images: [URL] {
        return photos?.compactMap { URL.init(string: $0) } ?? []
    }

    var formattedImageUrl: URL? {
        if let imageUrl = imageURL {
            return URL(string: imageUrl)
        }
        return nil
    }

    // convert day of the week 0-6 monday-sunday to 1-7 sunday - saturday
    var dayOfTheWeek: String {
        let dayOfTheWeek = [1: 6, 2: 0, 3: 1, 4: 2, 5: 3, 6: 4, 7: 5] // Update here <----
        let currentDay = day
        let newDay = dayOfTheWeek[currentDay]
        return
            hours.flatMap {
                $0.compactMap { $0.hourOpen?.first(where: { $0.day == newDay }) }.first
            }?.getReadableTime ?? "No Time"
    }

    // Current day number of the weekday
    var day: Int {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday ?? 0
    }

}

extension Open {

    // Military time to hour:min ex: 1000 to 10:00
    var getReadableTime: String {
        guard let start = start, let end = end else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HHmm"
        let startTime = dateFormatter.date(from: start)!
        let endTime = dateFormatter.date(from: end)!
        dateFormatter.dateFormat = "h:mm a"
        return "\(dateFormatter.string(from: startTime)) - \(dateFormatter.string(from: endTime))"
    }

}
//getting only the necessary properties for code data

extension Business {
    init(
        model: BusinessModel
    ) {
        self.init(
            id: model.id,
            alias: nil,
            name: model.name,
            imageURL: model.imageUrl,
            isClaimed: nil,
            isClosed: nil,
            url: nil,
            phone: nil,
            displayPhone: nil,
            reviewCount: nil,
            categories: [.init(alias: nil, title: model.category)],
            rating: Double(model.rating ?? "0"),
            location: nil,
            coordinates: nil,
            photos: nil,
            price: nil,
            hours: nil,
            transactions: nil,
            specialHours: nil
        )
    }
}
