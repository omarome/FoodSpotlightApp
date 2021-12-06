//
//  MyMapView.swift
//  FoodSpotlightApp
//
//  Created by Omar on 22.11.2021.
//


import MapKit
import SwiftUI

@available(iOS 15.0, *)
struct MyMapView: View {
    let id: String
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            // Spacer
            Rectangle()
                .fill(Color.clear)

            // Map
            Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.business != nil ? viewModel.business!.mapItems : []) {
                MapMarker(coordinate: $0.coordinate, tint: .blue)
            }
            .frame(height: UIScreen.main.bounds.height * 1)

        }
        .ignoresSafeArea(edges: [.top, .bottom])
        .onAppear {
            viewModel.requestDetails(forId: id)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    HStack{
                        Image( systemName: "chevron.backward.circle.fill")
                            .font(.title)
                        Text("Details")
                    }
                }
                .tint(.blue)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
@available(iOS 15.0, *)
struct MyMapView_Previews: PreviewProvider {
    static var previews: some View {
        MyMapView(id: "WavvLdfdP6g8aZTtbBQHTw")
            .environmentObject(HomeViewModel())
    }
}

