
//  ContentViewModel.swift
//  FoodSpotlightApp
//
//  Created by Omar on 22.11.2021.
//
// most of the logec for the Middleware happining here
import Combine
import CoreLocation
import ExtensionKit
import Foundation
import MapKit
import CoreData

final class HomeViewModel: ObservableObject {

    @Published var businesses = [Business]()
    @Published var searchText: String
    @Published var selectedCategory: FoodCategory
    @Published var region: MKCoordinateRegion
    @Published var business: Business?
    @Published var showModal: Bool
    @Published var cityName = ""
    @Published var completions = [String]()
    @Published var ShowFavorite = false
    
    var cancellables = [AnyCancellable]()
    //location manager 
    let manager = CLLocationManager()
    
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BusinessModel")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Could not find core data database!")
            }
        }
        return container
    }()
// initilazing the model variables
    init() {
        searchText = ""
        selectedCategory = .all
        region = .init()
        business = nil
        showModal = manager.authorizationStatus == .notDetermined
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters

        request()
    }
//request user premission to track his location
    func requestPermission() {
        manager
            .requestLocationWhenInUseAuthorization()
            .map { $0 == .notDetermined }
            .assign(to: &$showModal)
    }

    func getLocation() -> AnyPublisher<CLLocation, Never> {
        manager.receiveLocationUpdates(oneTime: true)
            .replaceError(with: [])
            .compactMap(\.first)
            .eraseToAnyPublisher()
    }
// send a request to the api using the seachText variable to bring the results according to the latest current location of the user
    func request(service: YelpApiService = .live) {
        let location = getLocation().share()

        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .combineLatest($showModal, $selectedCategory, location)
            .map { (term, show, category, location) in
                service.request(
                    .search(
                        term: term,
                        location: location,
                        category: term.isEmpty ? category : nil
                    )
                )
            }
            .switchToLatest()
            .assign(to: &$businesses)

        location
            .map {
                $0.reverseGeocode()
            }
            .switchToLatest()
            .compactMap(\.first)
            .compactMap(\.locality)
            .replaceError(with: "")
            .assign(to: &$cityName)

        $searchText
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .combineLatest(location)
            .map { term, location in
                service.completion(.completion(text: term, location: location))
            }
            .switchToLatest()
            .map { $0.map(\.text) }
            .assign(to: &$completions)
    }
// sending a reuest to the server to provide the details of the places to the user
    func requestDetails(forId id: String, service: YelpApiService = .live) {

        service
            .details(.detail(id: id))
            .sink { _ in

            } receiveValue: { [weak self] business in
                let coor = CLLocationCoordinate2D(
                    latitude: business?.coordinates?.latitude ?? 0,
                    longitude: business?.coordinates?.longitude ?? 0
                )
                let region = MKCoordinateRegion(
                    center: coor,
                    span: .init(latitudeDelta: 0.001, longitudeDelta: 0.001)
                )
                self?.business = business
                self?.region = region
            }.store(in: &cancellables)
        
    }

    // MARK - Core Data
    
    func save(business: Business, with context: NSManagedObjectContext) throws {
        let model = BusinessModel(context: context)
        model.id = business.id
        model.imageUrl = business.imageURL
        model.name = business.name
        model.category = business.formattedCategory
        model.rating = business.formattedRating
        try context.save()
    }
}
