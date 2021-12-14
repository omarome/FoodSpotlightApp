//
//  DetailCard.swift
//  FoodSpotlightApp
//
//  Created by iosdev on 1.12.2021.
//

import ExtensionKit
import SwiftUI

// providing all the necessary details of a business for the DetailView
struct DetailCard: View {
   
    let business: Business
    var body: some View {
        NavigationView{
          
            VStack(alignment: .leading, spacing: 2) {
                //  a label to redirect to mapview
                VStack{
                    NavigationLink(destination: MyMapView(id: self.business.id ?? "WavvLdfdP6g8aZTtbBQHTw")) {
                                       Label("Location", systemImage: "location")
                                           .accessibilityLabel(Text("Location"))
                        
                        
                    }
                }
                //
                Spacer()
                
                Group {
                    Text(business.formattedName)
                        .font(.custom(.poppinsSemibold, size: 18))
                        .foregroundColor(.black)
                    Text(business.formattedCategories)
                        .font(.custom(.poppinsRegular, size: 12))
                        .foregroundColor(.gray)
                        .padding(.bottom, .large)
                }

                Group {
                    HStack {
                        Image(Asset.map.name)
                        Button(action: navigate) {
                            Text(business.formattedAddress)
                            Image(systemName: "map")
                        }
                        Image(Asset.star.name)
                        Text(business.formattedRating)
                            .foregroundColor(.black)
                        Image(Asset.money.name)
                        Text(business.formattedPrice)
                            .foregroundColor(.black)
                    }.font(.subheadline)
                }
                .font(.custom(.poppinsRegular, size: 14))

                Group {
                    HStack {
                        Image(Asset.clock.name)
                        Text(business.dayOfTheWeek)
                            .foregroundColor(.black)
                        Image(Asset.phone.name)
                        Button(action: phone) {
                            Text(business.formattedPhoneNumber)
                        }
                        Spacer()
                    }
                    .font(.subheadline)
                    .padding(.bottom, .large)
                }
                .font(.custom(.poppinsRegular, size: 14))

                Group {
                    TabView {
                        ForEach(business.images, id: \.self) { url in
                            AsyncImage.init(url: url) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Color.gray.shimmer()
                            }

                        }
                    }
                    .frame(height: 450)
                    .cornerRadius(.large)
                    .tabViewStyle(.page)
                }

            }
            .padding().padding()
            .background(Color.white)
            .cornerRadius(.xLarge)
            .modifier(ShadowModifier())
            .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height * 1)
            }
        
    }
    func phone() {
        UIApplication.shared.openPhone(calling: business.phone ?? "")
    }
    
// direct the user to google map
    func navigate() {
        let query = "\(business.coordinates?.latitude ?? 0),\(business.coordinates?.longitude ?? 0)"
        UIApplication.shared.openExternalMapApp(query: query)
    }
}

