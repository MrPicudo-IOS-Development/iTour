//
//  SwiftUIView.swift
//  iTour
//
//  Created by Jose Miguel Torres Chavez Nava on 06/04/24.
//

import SwiftData
import SwiftUI

struct SwiftUIView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var destinations: [Destination]
    
    var body: some View {
        NavigationStack {
            ForEach(destinations) { destiny in
                List {
                    ForEach(destinations) { eco in
                        Text("Eco \(eco.name)")
                    }
                    .toolbar {
                        Button("Add samples", action: addSamples)
                    }
                }
            }
        }
    }
    
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
}

#Preview {
    SwiftUIView()
}
