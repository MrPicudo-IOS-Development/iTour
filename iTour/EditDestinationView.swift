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
    
    // State variable which receives the user input for "seights"
    @State private var newSightName = ""
    
    var body: some View {
        Form {
            TextField(NSLocalizedString("EDV.TextField01", comment: "Name"), text: $destination.name)
            TextField(NSLocalizedString("EDV.TextField02", comment: "Details"), text: $destination.details, axis: .vertical)
            DatePicker(NSLocalizedString("EDV.TextField03", comment: "Date"), selection: $destination.date)
            
            Section(NSLocalizedString("EDV.Section01", comment: "Priority")) {
                Picker(NSLocalizedString("EDV.Picker", comment: "Priority"), selection: $destination.priority) {
                    Text(NSLocalizedString("EDV.Text01", comment: "Meh")).tag(1)
                    Text(NSLocalizedString("EDV.Text02", comment: "Maybe")).tag(2)
                    Text(NSLocalizedString("EDV.Text03", comment: "Must")).tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section(NSLocalizedString("EDV.Section02", comment: "Sights")) {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                .onDelete(perform: deleteSight)
                HStack {
                    TextField("\(NSLocalizedString("EDV.TextField04", comment: "Add a new sight in")) \(destination.name)", text: $newSightName)
                    Button(NSLocalizedString("EDV.Button", comment: "Add"), action: addSight)
                }
            }
        }
        .navigationTitle(NSLocalizedString("EDV.navTitle", comment: "Edit destination"))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSight() {
        // First, we check the function is not being called with empty data.
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
    
    func deleteSight(_ indexSet: IndexSet) {
        for index in indexSet {
            // We don't need the method "insert(object)" from the modelContext because that is just for working with the main class model.
            destination.sights.remove(at: index)
        }
    }
}

#Preview {
    do {
        // A custom "ModelConfiguration" object to work with "in-memory" storage
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        // We use the config to create a model container for the previews
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example destination", details: "Example details go here and will automatically expand vertically as they are edited." )
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
