//
//  ContentViewModel.swift
//  FoodSpotlightApp
//
//  Created by Omar on 22.11.2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    
    
    @Published var businesses = [Business]()
    //this publisher going to emit values to our search.
    @Published var searchText = ""
    
    //this function will get an instance of our Yelp Clint
    func search() {
        // get in instance of Yelp clint
        let live  = YelpApiService.live
        
        //calling search takes paramiters (term, location , category)
        live.search("food", .init(latitude: 60.1699, longitude: 24.9384), nil)
            .assign(to: &$businesses)
    }
   // @Published var allItems [ItemModel] = []
    /*
    @Published var searchText = ""
    
    //private let dataService = allDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    func addSubscribers() {
       
        /*
         dataService.$allItems
            .sink{ [weak self] (returnItems)in
                self?.allItems = returnItems
            }
            .store{in: &cancellables}
         */
    }
     */
}
