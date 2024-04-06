//
//  Destination.swift
//  iTour
//
//  Created by Jose Miguel Torres Chavez Nava on 04/04/24.
//

import Foundation
import SwiftData

@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    // Each destination has many sights asociated with.
    @Relationship(deleteRule: .cascade) var sights = [Sight]()
    // The relationship with the delete rule "cascade" means that everytime we delete a Destination object, all the sights related to it will also be deleted.
    
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
