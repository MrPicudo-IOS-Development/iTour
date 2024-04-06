//
//  DestinationListingView.swift
//  iTour
//
//  Created by Jose Miguel Torres Chavez Nava on 05/04/24.
//

import SwiftData
import SwiftUI

struct DestinationListingView: View {
    
    // Variable neede to use "modelContext" with .add() and .delete() functions.
    @Environment(\.modelContext) var modelContext
    
    @Query var destinations: [Destination]
    
    var body: some View {
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
/* For the modifiers of this View in ContentView, specifically:
 .navigationDestination(for:, destination:)
 
Using .init in this context is a shorthand way of passing a function that initializes EditDestinationView with a Destination instance. Essentially, it tells SwiftUI, "When it's time to navigate, use this initializer of EditDestinationView to create the view, passing the Destination instance as an argument."
             
When you pass EditDestinationView.init as the closure, you're not instantiating the EditDestinationView right away. Instead, you're passing a reference to its initializer. SwiftUI will call this initializer and pass the selected Destination object to it whenever the navigation is triggered.
*/
        }
    }
    
    // To build this View we need to pass a parameter of type "SortDescriptor" from the parent View.
    init(sort: SortDescriptor<Destination>, searchString: String) {
        // In order to control the Query and NOT the array of destinations, we need to add "_" at the beggining.
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true // We send all the results if we search bar is empty
            } else {
                // "localizedStandardContains()" is the best method to do user-facing string searches, because is not case sensitive as the regular "contains()" method.
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
    
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
