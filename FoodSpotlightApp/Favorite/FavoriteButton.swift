//
//  FavoriteButton.swift
//  FoodSpotlightApp
//
//  Created by Omar on 10.12.2021.
//
import SwiftUI
// this is the favorte button where the order for saving an item to the favorite list
struct FavoriteButton: View {
    var business : Business
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.managedObjectContext) var context

    var body: some View {
        Button(action: {
          
            do {
                try viewModel.save(business: business, with: context)
                print("Saved")
            } catch {
                print(error.localizedDescription)
            }
        
        }, label: {
            Image( "heart-filled" )
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 60)
                .foregroundColor( .red )
        })

    }
}

