//
//  Project-CoreDataHelpers.swift
//  StokeProgresion
//
//  Created by Kyle Price on 12/22/21.
//

import Foundation


extension Project {
    static let colors = [
        "Pink", "Purple", "Red", "Orange", "Gold",
        "Green", "Teal", "Light Blue", "Dark Blue",
        "Midnight", "Dark Gray", "Gray"
    ]
    
    var projectTitle: String { title ?? "New Project" }
    var projectDetail: String { detail ?? "" }
    var projectCreationDate: Date { creationDate ?? Date() }
    var projectColor: String { color ?? "Light Blue" }
    
    var allItems: [Item] {
        let itemsArray = items?.allObjects as? [Item] ?? []
        
        return itemsArray.sorted { first, second in
            if !first.completed {
                if second.completed {
                    return true
                }
            } else if first.completed {
                if !second.completed {
                    return false
                }
            }
            
            if first.priority > second.priority {
                return true
            } else if first.priority < second.priority {
                return false
            }
            
            return first.itemCreationDate < second.itemCreationDate
        }
    }
    
    var completionAmount: Double {
        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else { return 0.0 }
        
        let completedItems = originalItems.filter(\.completed)
        
        return Double(completedItems.count) / Double(originalItems.count )
    }
    
    static var example: Project {
        let ctlr = DataController(inMemory: true)
        let ctx = ctlr.container.viewContext
        
        let project = Project(context: ctx)
        project.title = "Example Project"
        project.detail = "This is an example project"
        project.creationDate = Date()
        project.closed = true
        
        return project
    }
}
