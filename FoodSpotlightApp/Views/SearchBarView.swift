//
//  SearchBarView.swift
//  FoodSpotlightApp
//
//  Created by Omar on 30.11.2021.
//


import SwiftUI

struct SearchBarView: View {
    
    @State var searchText : String = ""
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.secondary : Color.brown)
            
            TextField("Search by name or symbol ...", text : $searchText)
                .foregroundColor(Color.black)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.brown)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
            
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: Color.accentColor.opacity(0.15),
                        radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
      
            SearchBarView()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)

        }
}
