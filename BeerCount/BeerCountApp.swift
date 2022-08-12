//
//  BeerCountApp.swift
//  BeerCount
//
//  Created by Eduardo Ximenes on 10/08/22.
//

import SwiftUI
import Firebase

@main
struct BeerCountApp: App {
    
    @StateObject var dataManager = DataManager()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomePage()
                .environmentObject(dataManager)
        }
    }
}
