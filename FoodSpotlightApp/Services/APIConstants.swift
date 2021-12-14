//
//  APIConstants.swift
//  FoodSpotlightApp
//
//  Created by Omar on 14.12.2021.
//

import Foundation
// this file should be added to the gitignore file, but because it is needed for the teacher to run the application, we did not add it.

struct APIConstants{
    let apiKey = "i24sX5x5ZwnVNn62LnB7qRu23AnHGShPBZTO927rV3m0hhhWYt_o7kv_DuLLx6scV35IykOqF7n9bLtNkR0JJ_51yE1iZNBUxRQjD-Q4FMkRZbw1gJlucNzok_WcYXYx"
    
    let APIBase = "https://api.yelp.com"
    let APISearch = "/v3/businesses/search"
    let APIDetails = "/v3/businesses/"
    let APIComplation = "/v3/autocomplete"
}
