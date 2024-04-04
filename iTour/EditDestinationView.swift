//
//  EditDestinationView.swift
//  iTour
//
//  Created by Jose Miguel Torres Chavez Nava on 04/04/24.
//

import SwiftData
import SwiftUI

struct EditDestinationView: View {
    
    // Una variable con propiedad "Bindable" para que sus valores puedan ser editados por textflieds y pickers.
    @Bindable var destination: Destination
    
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)
            
            Section("Piority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle("Edit destination")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        // A custom "ModelConfiguration" object to work with "in-memory" storage
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        // We use the config to create a model container for the previews
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example destination", details: "Example details go here and will automatically expand vertically as they are edited.")
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
    
    // EditDestinationView()
}
