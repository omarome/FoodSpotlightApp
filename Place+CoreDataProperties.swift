//
//  Place+CoreDataProperties.swift
//  FoodSpotlightApp
//
//  Created by Omar on 30.11.2021.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var alias: String?
    @NSManaged public var distance: Double
    @NSManaged public var id: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var isClosed: Bool
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var rating: Double
    @NSManaged public var title: String?

}

extension Place : Identifiable {

}
