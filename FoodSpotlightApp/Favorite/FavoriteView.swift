//
//  ProfileView.swift
//  FoodSpotlightApp
//
//  Created by iosdev on 1.12.2021.
//

import Foundation
import CoreData
import SwiftUI

struct FavoriteView: View {

    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: BusinessModel.entity(),
        sortDescriptors: [],
        animation: .easeInOut
    ) var businessModels: FetchedResults<BusinessModel>

    var businesses: [Business] {
        businessModels.map(Business.init(model:))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Favorite Restaurants")
                .font(.title)
                .bold()
                .padding()
            Divider()
            List(businesses, id: \.id) { business in
                BusinessCell(business: business)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete", role: .destructive) {
                            // Delete
                            if let id = business.id {
                                deleteModel(for: id)
                            }
                        }
                    }
            }.listStyle(.plain)
                .listSectionSeparator(.hidden)
            Spacer()
        }
    }

    func deleteModel(for id: String) {
        if let model =
            businessModels
            .first(where: { $0.id == id })
        {
            context.delete(model)
            do {
                try context.save()
            } catch { print(error.localizedDescription) }
        }
    }

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
