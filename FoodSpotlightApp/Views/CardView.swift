//
//  CardView.swift
//  FoodSpotlightApp
//
//  Created by Omar on 30.11.2021.
//
import SwiftUI
struct CardView: View {
    var business: Business?
    var fetchedData :Place?
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10, content: {
                
            Text((business == nil ? fetchedData?.name ?? "name 0" : business?.name) ?? "no name")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            Text((business == nil ? fetchedData?.id ?? "no id" : business?.id) ?? " there is no id")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            Text(String((business == nil ? fetchedData?.longitude ?? 0.0 : business?.coordinates?.longitude) ?? 0.0))
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
        })
        
    }
}


