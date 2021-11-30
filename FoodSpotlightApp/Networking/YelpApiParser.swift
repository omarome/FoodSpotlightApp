//
//  YelpApiParser.swift
//  FoodSpotlightApp
//
//  Created by Omar on 30.11.2021.
//

import Foundation
import CoreLocation
import Combine

class YelpApiParser: ObservableObject {
    let apiConstant = APIConstants()
  
    func urlRequest(term: String, location: CLLocation, cat: String ) -> URLRequest {

        var urlComponents = URLComponents(string: "https://api.yelp.com")!
        urlComponents.path = "/v3/businesses/search"
        urlComponents.queryItems = [
            .init(name: "term", value: term),
            .init(name: "longitude", value: String(location.coordinate.longitude)),
            .init(name: "latitude", value: String(location.coordinate.latitude)),
            .init(name: "categories", value: cat ),
        ]
        let url = urlComponents.url!
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(apiConstant.apikey)", forHTTPHeaderField: "Authorization")
        
        return urlRequest

    }
}

