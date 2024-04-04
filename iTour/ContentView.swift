//
//  ContentView.swift
//  iTour
//
//  Created by Jose Miguel Torres Chavez Nava on 04/04/24.
//

import SwiftData
import SwiftUI

/// In this View we work with the "path" of the NavigationStack dinamically, by sending a new destination to the path, we control programatically what's showing in our stack.
struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var destinations: [Destination]
    
    // Variable that controls the path of the NavigationStack
    @State private var path = [Destination]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(destinations) { destination in
                    NavigationLink(value: destination) {
                        VStack(alignment: .leading) {
                            Text(destination.name)
                                .font(.headline)
                            Text(destination.date.formatted(date: .long, time: .shortened))
                        }
                    }
                }
                .onDelete(perform: deleteDestinations)
            }
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .toolbar {
                // Button("Add samples", action: addSamples)
                Button("Add", systemImage: "plus", action: addDestination)
            }
        }
        
    }
    
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
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
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
