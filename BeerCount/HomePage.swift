//
//  HomePage.swift
//  BeerCount
//
//  Created by Eduardo Ximenes on 11/08/22.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView{
            List(dataManager.beers, id: \.id){ beer in
                Text(beer.name)
            }
            .navigationTitle("Beers")
            .navigationBarItems(trailing: Button(action: {//add
            }, label: {
                Image(systemName: "plus")
            }    ))
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .environmentObject(DataManager())
    }
}
