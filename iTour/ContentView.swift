//
//  ContentView.swift
//  iTour
//
//  Created by Jose Miguel Torres Chavez Nava on 04/04/24.
//

import SwiftData
import SwiftUI

/// In this View we work with the "path" of the NavigationStack dinamically, by sending a new destination to the path, we control programatically what's showing in our stack. Selections within the List (via NavigationLink) or programmatic updates to path (such as in addDestination()) lead to navigation changes. Specifically, when a Destination is added to path, the app navigates to EditDestinationView with that destination.
struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    // Variable that controls the path of the NavigationStack
    @State private var path = [Destination]() // It's an empty array at the beginning.
    
    // Variable que almacena el orden elegido por el usuario, que contiene un valor sensato por default.
    @State private var sortOrder = SortDescriptor(\Destination.name)
    
    // Variable that controls the user input in the search bar.
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText) // We send the sortOrder chosen by the user to build the View.
            .navigationTitle("iTour")
            .searchable(text: $searchText)
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .toolbar {
                Button("Add", systemImage: "plus", action: addDestination)
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name")
                            .tag(SortDescriptor(\Destination.name))
                        Text("Priority")
                            .tag(SortDescriptor(\Destination.priority, order: .reverse))
                        Text("Date")
                            .tag(SortDescriptor(\Destination.date))
                    }
                    .pickerStyle(.inline)
                }
            }
        }
    }
    
    func addDestination() {
        // We create the new object and we added it to the modelContext.
        let destination = Destination()
        modelContext.insert(destination)
        // Now we trigger the editing view for this object right away.
        path = [destination]
    }
}

#Preview {
    ContentView()
}


/* Código de referencia:
 
 /* En el toolbar:
    // Button("Add samples", action: addSamples) */
 
 // Función temporal para mostrar ejemplos en nuestra app.
 func addSamples() {
     // We created the Destination objects
     let rome = Destination(name: "Rome")
     let florence = Destination(name: "Florence")
     let naples = Destination(name: "Naples")
     // But we have to add them to the store
     modelContext.insert(rome)
     modelContext.insert(florence)
     modelContext.insert(naples)
 }
 
 */
