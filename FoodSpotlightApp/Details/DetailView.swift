//
//  DetailView.swift
//  FoodSpotlightApp
//
//  Created by iosdev on 1.12.2021.
//

import MapKit
import SwiftUI

@available(iOS 15.0, *)
struct DetailView: View {
    
    let id: String
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        ZStack(alignment: .top) {
            // Spacer
            Rectangle()
                .fill(Color.clear)
        

        }.overlay(
            // Card
            viewModel.business != nil ? DetailCard(business: viewModel.business!) : nil,
            alignment: .top //.center
        )
        //.ignoresSafeArea(edges: [.top, .bottom])
        .onAppear {
            viewModel.requestDetails(forId: id)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    HStack{
                        Image(systemName: "chevron.backward.circle.fill")
                            .font(.title)
                        Text("Home")
                    }
                }
                .tint(.blue)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

@available(iOS 15.0, *)
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: "WavvLdfdP6g8aZTtbBQHTw")
            .environmentObject(HomeViewModel())
    }
}
