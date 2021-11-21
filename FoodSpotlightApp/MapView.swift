//
//  mapView.swift
//  FoodSpotlightApp
//
//  Created by Omar on 21.11.2021.
//

import SwiftUI
import MapKit

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double ){
        self.id = id
        self.location = CLLocationCoordinate2D(
        latitude: lat, longitude: long)
    }
    
}
struct MapView: View {
    let  place = IdentifiablePlace(lat: 51.507222, long: -0.1275)
    private let locationManager = CLLocationManager()
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
 
    var body: some View {
        VStack {
            Button("Init Map") {
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.requestWhenInUseAuthorization()
            }
   
            Map(coordinateRegion: $region,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
        annotationItems: [place]) {place in MapPin(coordinate: place.location,
                                                   tint:Color.blue)
        
        }
    }
}
}

struct mapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
