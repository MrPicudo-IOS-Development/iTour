//
//  Sight.swift
//  iTour
//
//  Created by Jose Miguel Torres Chavez Nava on 06/04/24.
//

import SwiftData
import Foundation

/// This is going to be the second class model in our project, and it's having a relationship with the main class model.
@Model
class Sight {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
