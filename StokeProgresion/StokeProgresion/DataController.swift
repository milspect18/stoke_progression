//
//  DataController.swift
//  StokeProgresion
//
//  Created by Kyle Price on 12/19/21.
//

import CoreData
import SwiftUI


class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        self.container = NSPersistentCloudKitContainer(name: "main")
        
        if inMemory {
            self.container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        self.container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Fatal error loading store!  \(error.localizedDescription)")
            }
        }
    }
    
    static var preview: DataController = {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        do {
            try controller.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }
        
        return controller
    }()
    
    func createSampleData() throws {
        let viewContext = self.container.viewContext
        
        for i in 1...5 {
            let project = Project(context: viewContext)
            project.title = "Project \(i)"
            project.items = []
            project.creationDate = Date()
            project.closed = Bool.random()
            
            for j in 1...10 {
                let item = Item(context: viewContext)
                item.title = "Item \(j)"
                item.creationDate = Date()
                item.completed = Bool.random()
                item.project = project
                item.priority = Int16.random(in: 1...3)
            }
        }
        
        try viewContext.save()
    }
    
    func save() {
        if self.container.viewContext.hasChanges {
            try? self.container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        self.container.viewContext.delete(object)
    }
    
    func deleteAll() {
        let itemBatchDelete = NSBatchDeleteRequest(fetchRequest: Item.fetchRequest())
        _ = try? self.container.viewContext.execute(itemBatchDelete)
        
        let projectBatchDelete = NSBatchDeleteRequest(fetchRequest: Project.fetchRequest())
        _ = try? self.container.viewContext.execute(projectBatchDelete)
    }
}
