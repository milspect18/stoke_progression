//
//  EditItemView.swift
//  StokeProgresion
//
//  Created by Kyle Price on 12/23/21.
//

import SwiftUI

struct EditItemView: View {
    @EnvironmentObject var dataController: DataController
    @State private var title: String
    @State private var detail: String
    @State private var priority: Int
    @State private var completed: Bool
    let item: Item
    
    init(item: Item) {
        self.item = item
        _title = State(wrappedValue: item.itemTitle)
        _detail = State(wrappedValue: item.itemDetail)
        _priority = State(wrappedValue: Int(item.priority))
        _completed = State(wrappedValue: item.completed)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Item Settings")) {
                TextField("Item Name", text: $title)
                TextField("Description", text: $detail)
            }
            
            Section(header: Text("Priority")) {
                Picker("Priority", selection: $priority) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("High").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section {
                Toggle("Completed", isOn: $completed)
            }
        }
        .navigationTitle("Edit Item")
        .onDisappear { update()  }
    }
    
    func update() {
        item.project?.objectWillChange.send()
        item.title = title
        item.detail = detail
        item.completed = completed
        item.priority = Int16(priority)
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item.example)
    }
}