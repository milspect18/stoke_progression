//
//  StokeProgresionApp.swift
//  StokeProgresion
//
//  Created by Kyle Price on 12/19/21.
//

import SwiftUI

@main
struct StokeProgresionApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let controller = DataController()
        _dataController = StateObject(wrappedValue: controller)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
