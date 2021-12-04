//
//  HomeViewModel.swift
//  FoodSpotlightApp
//
//  Created by Omar on 1.12.2021.
//

import SwiftUI
import Foundation
import Combine
import CoreData

class HomeViewModel: ObservableObject{
    
    

    //this publisher going to emit values to our search.
    @Published var searchText = ""
    
    //this function will get an instance of our dataTaskCall
    func search() {

        // get in instance of Yelp clint
      //  let live  = YelpApiService.live
        
        //calling search takes paramiters (term, location , category)
      //  live.search("food", .init(latitude: 60.1699, longitude: 24.9384), nil)
        //    .assign(to: &$businesses)
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
