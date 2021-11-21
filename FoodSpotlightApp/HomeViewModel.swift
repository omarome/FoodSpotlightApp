//
//  ContentViewModel.swift
//  FoodSpotlightApp
//
//  Created by Omar on 22.11.2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
   // @Published var allItems [ItemModel] = []
    
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
}
