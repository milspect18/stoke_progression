//
//  ItemRowView.swift
//  StokeProgresion
//
//  Created by Kyle Price on 12/23/21.
//

import SwiftUI

struct ItemRowView: View {
    @ObservedObject var project: Project
    @ObservedObject var item: Item
    
    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
            Text(item.itemTitle)
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(project: Project.example, item: Item.example)
    }
}
