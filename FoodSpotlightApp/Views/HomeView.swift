
//
//  HomeView.swift
//  FoodSpotlight2
//
//  Created by Omar on 28.11.2021.
//

import SwiftUI
import CoreData

struct HomeView: View {

    
    var body: some View {
        
            VStack{
                
                VStack{
                    Text("Food Spotlight")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame( height: 50)
                        .frame(maxWidth: .infinity)
                    //search bar didnt bind it with data yet
                    SearchBarView()
                }
                ListView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
