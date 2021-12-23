//
//  Item-CoreDataHelpers.swift
//  StokeProgresion
//
//  Created by Kyle Price on 12/22/21.
//

import Foundation

extension Item {
    var itemTitle: String { title ?? "" }
    var itemDetail: String { detail ?? "" }
    var itemCreationDate: Date { creationDate ?? Date() }
    
    static var example: Item {
        let controller = DataController(inMemory: true)
        let context = controller.container.viewContext
        
        let item = Item(context: context)
        item.title = "Example Item"
        item.detail = "This is an example item"
        item.creationDate = Date()
        item.priority = 3
        
        return item
    }
}
