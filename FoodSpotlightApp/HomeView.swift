//
//  ContentView.swift
//  FoodSpotlightApp
//
//  Created by Omar on 19.11.2021.
//

import SwiftUI
import CoreData
import MapKit

// this is the home page
struct HomeView: View {
   // @EnvironmentObject private var hv: ContentViewModel
   
        
    
    var body: some View {
        
            ScrollView{
        //headline with name of the app
                VStack{
                    Text("Food Spotlight")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame( height: 50)
                        .frame(maxWidth: .infinity)
                    //search bar didnt bind it with data yet
                    SearchBarView()
                }.foregroundColor(.white)
                    
                    .background(Color("appMainColor"))
             // map view
                    VStack{
                        MyMapView()
                       
                    }   .frame( height: 500)
                        .frame(width: 375)
                        .padding()
                //rounding the background from the right side only
                        .background(RoundedCorners(color: .white, tl: 0, tr: 60, bl: 0, br: 0))
               
               // here is the bottom bar, which should show the language and favorite list
                HStack{
                    Text("footer")
                    
                }
            
            }.background(Color("appMainColor"))

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
    
}
