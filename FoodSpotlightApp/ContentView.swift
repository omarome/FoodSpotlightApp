//
//  ContentView.swift
//  FoodSpotlightApp
//
//  Created by Omar on 19.11.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
            ScrollView{
                VStack{
                    Text("Food Spotlight")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame( height: 128)
                        .frame(maxWidth: .infinity)
                }.foregroundColor(.white)
                    .padding()
                    .background(Color("appMainColor"))
                VStack{
                    Text("Body ")
                        .foregroundColor(Color.blue)
                        .padding()
                        
                }   .frame( height: 380)
                    .frame(width: 375)
                    
                    .background(RoundedCorners(color: .white, tl: 0, tr: 60, bl: 0, br: 0))
                    .padding()
                HStack{
                    Text("footer")
                    
                }
            
            }.background(Color("appMainColor"))

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}
