//
//  MapView.swift
//  FoodSpotlight
//
//  Created by sasha on 30.11.2021.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.192059, longitude: 24.945831), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

    var body: some View {
            VStack {
                Map(coordinateRegion: $region, showsUserLocation: true) //permission for using user location
                    .ignoresSafeArea() //full screen map
                    .accentColor(Color(.systemPink))
                    .onAppear {
                        viewModel.checkIfLocationIsEnabled()
                    }

                //just for checking
                Button("zoom") {
                    withAnimation {
                        region.span = MKCoordinateSpan(
                            latitudeDelta: 10,
                            longitudeDelta: 10
                        )
                    }
                }
            }
        }
    }

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    //optional, we should check for location is On or Off
    
    func checkIfLocationIsEnabled() {
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager() // will call for update
            locationManager!.delegate = self
//            locationManager?.desiredAccuracy = kCLLocationAccuracyBest //check documentation for this setting
        } else {
            print("Show an alert that location is OFF")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted")
        case .denied:
            print("Location permission denied")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
 
struct MapView_Previews: PreviewProvider {
        static var previews: some View {
            MapView()
        }
    }
