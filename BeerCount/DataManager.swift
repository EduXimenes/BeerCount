//
//  DataManager.swift
//  BeerCount
//
//  Created by Eduardo Ximenes on 11/08/22.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject{
    @Published var beers: [Beer] = []
    
    init(){
        fetchBeers()
    }
    
    
    func fetchBeers(){
        beers.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Beers")
        ref.getDocuments{snapshot, error in
                         guard error == nil else {
            print(error!.localizedDescription)
            return
        }
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let price = data["price"] as? String ?? ""
                    let time = data["time"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    
                    let beer = Beer(id: id, name: name, price: price, time: time, description: description)
                    self.beers.append(beer)
                }
            }
        }
    }
}
