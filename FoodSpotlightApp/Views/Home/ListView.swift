//
//  ListView.swift
//  FoodSpotlightApp
//
//  Created by Omar on 4.12.2021.
//

import SwiftUI
import CoreData


struct ListView: View {
    @StateObject var jsonModel =  DataTaskModel()
    @Environment(\.managedObjectContext) var context
    
    // Fetching data from core data
    @FetchRequest(entity: Place.entity(), sortDescriptors:
                    [NSSortDescriptor(keyPath: \Place.name, ascending: true)]) var results: FetchedResults<Place>
    
    var body: some View {
        NavigationView {
            VStack {
                if results.isEmpty{
                    if jsonModel.businesses.isEmpty{
                        
                        ProgressView()
                        //fetching data
                            .onAppear(perform: {
                                jsonModel.dataTaskCall(context: context, term: "food",location: .init(latitude: 60.1699, longitude: 24.9384), cat: "restaurants")
                    
                            })
                        //when array is clear indicator appears
                        //as a result data is fetched again
                    }
                    else{
                        
                        List(jsonModel.businesses , id: \.self){ business in
                            //display fetched JSON Data
                            CardView(business: business)
                            
                        }.listStyle(InsetGroupedListStyle())
                    }
                    
                    
                    
                }else{
                    List(results){ business in
                        //display fetched JSON Data
                        CardView(fetchedData: business)
                        
                    }.listStyle(InsetGroupedListStyle())
                }

            }
            .listStyle(.plain)
            .navigationTitle(!results.isEmpty ? "fetch core data " : "Fetched JSON")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        
                        // by clearing array data..
                        // it will auto fetch all data
                        // clearing data in core data
                        do {
                            results.forEach{(item) in
                                context.delete(item)
                            }
                            try context.save()
                        }catch{
                            print(error.localizedDescription)
                        }
         
                    },label:{
                        Image(systemName: "arrow.clockwise.circle")
                            .font(.title)

                    })
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
