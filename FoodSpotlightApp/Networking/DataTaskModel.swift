//
//  DataTaskModel.swift
//  FoodSpotlightApp
//
//  Created by Omar on 30.11.2021.
//


import Foundation
import CoreData
import CoreLocation

class DataTaskModel: ObservableObject{
    @Published var businesses : [Business] = []
    let ylepApiParser = YelpApiParser()

  
    
    func dataTaskCall(context: NSManagedObjectContext,term: String, location: CLLocation, cat: String ){
        let dataTask = URLSession.shared.dataTask(with: ylepApiParser.urlRequest(term: term, location: location, cat: cat)) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {return}
            if response.statusCode == 200 {
              //  print(response.statusCode)
                guard let data = data else {return}
             
                //print("data before decode: \(data.count)")
         
                DispatchQueue.main.async {
                    do {
                        //let jsonData = data.data(using: .utf8)!
                        let decodeQuery = try JSONDecoder().decode(BusinessesModel.self, from: data)
                        DispatchQueue.main.async {
                           // print("decode quary:\(decodeQuery.businesses) ")
                            self.businesses = decodeQuery.businesses
                           // print("businesses: \(self.businesses.count)")
                            
                            //save it in the core data
                            
                            self.saveData(context: context)
                            
                         
                        }
                   
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    //saving JSON TO Core Data
    func saveData(context: NSManagedObjectContext){
        businesses.forEach {(data) in
            
            let entity = Place(context: context)
            entity.id = data.id
            entity.imageURL = data.imageURL
            entity.name = data.name
            entity.rating = data.rating!
            entity.latitude = data.coordinates?.latitude ?? 0.0
            entity.longitude = data.coordinates?.longitude ?? 0.0
         //   let coordinatesEntity = PlacesCoordinates(context: context)
           // coordinatesEntity.latitude = data.coordinates?.latitude ?? 0.0
            //coordinatesEntity.longitude = data.coordinates?.longitude ?? 0.0
        }
        // saving all pending data at once
        do{
            try context.save()
            print("success")
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
}
