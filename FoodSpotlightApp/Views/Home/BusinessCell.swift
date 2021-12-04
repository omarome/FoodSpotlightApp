//
//  BusinessCell.swift
//  FoodSpotlightApp
//
//  Created by Omar on 3.12.2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct BusinessCell: View {
    let business: Business

    var body: some View {
        HStack {
            // Image
            AsyncImage(url: business.formattedImageUrl) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 110, height: 110)
            .cornerRadius(10)
            .padding(4)

            // Labels
            VStack(alignment: .leading, spacing: 4) {
                Text(business.formattedName)
                   
                Text(business.formattedCategory)
                   
                    .foregroundColor(.gray)
                HStack {
                    Text(business.formattedRating)
                        
                    Image("star")
                }
            }
            Spacer()
        }
        .foregroundColor(.black)
        .padding(4)
        .background(Color.white)
        .cornerRadius(8)
        .modifier(ShadowModifier())
    }
}

@available(iOS 15.0, *)
struct BusinessCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BusinessCell(
                business: .init(
                    id: nil,
                    alias: nil,
                    name: "Sweetgreen",
                    imageURL: "https://s3-media1.fl.yelpcdn.com/bphoto/j_Ut4i4j2Q4d2TVEDPVt4g/o.jpg",
                    isClaimed: nil,
                    isClosed: nil,
                    url: nil,
                    phone: nil,
                    displayPhone: nil,
                    reviewCount: nil,
                    categories: nil,
                    rating: 4.5,
                    location: nil,
                    coordinates: nil,
                    photos: nil,
                    price: nil,
                    hours: nil,
                    transactions: nil,
                    specialHours: nil
                )
            )
            BusinessCell(
                business: .init(
                    id: nil,
                    alias: nil,
                    name: "Sweetgreen",
                    imageURL: "https://s3-media1.fl.yelpcdn.com/bphoto/j_Ut4i4j2Q4d2TVEDPVt4g/o.jpg",
                    isClaimed: nil,
                    isClosed: nil,
                    url: nil,
                    phone: nil,
                    displayPhone: nil,
                    reviewCount: nil,
                    categories: nil,
                    rating: 4.5,
                    location: nil,
                    coordinates: nil,
                    photos: nil,
                    price: nil,
                    hours: nil,
                    transactions: nil,
                    specialHours: nil
                )
            )
            .environment(\.colorScheme, .dark)
        }
    }
}
